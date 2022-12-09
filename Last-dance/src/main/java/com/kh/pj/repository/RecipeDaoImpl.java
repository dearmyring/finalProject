package com.kh.pj.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.RecipeDto;
import com.kh.pj.vo.RecipeCountVO;
import com.kh.pj.vo.RecipeListSearchVO;
import com.kh.pj.vo.RecipeListVO;

@Repository
public class RecipeDaoImpl implements RecipeDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//레시피 등록 관련 시퀀스
	@Override
	public int recipeSequence() {
		return sqlSession.selectOne("recipe.recipeNo");
	}
	
	//레시피 등록(INSERT)
	@Override
	public void write(RecipeDto recipeDto) {
		sqlSession.insert("recipe.write", recipeDto);

	}
	
	//레시피 수정(UPDATE)
	@Override
	public boolean update(RecipeDto recipeDto) {
		int count = sqlSession.update("recipe.edit", recipeDto);
		return count > 0;

	}
	
	//레시피 삭제(DELETE)
	@Override
	public boolean delete(int recipeNo) {
		int count = sqlSession.delete("recipe.delete", recipeNo);
		return count > 0;

	}
	
	//레시피 상세(DETAIL)
	@Override
	public RecipeDto selectOne(int recipeNo) {
		return sqlSession.selectOne("recipe.detail", recipeNo);

	}
	
	//레시피 조회수 
	@Override
	public RecipeDto click(int recipeNo) {
		this.updateClickCount(recipeNo);
		return this.selectOne(recipeNo);
	}
	
	//레시피 조회수 증가
	@Override
	public boolean updateClickCount(int recipeNo) {
		String sql = "update recipe "
						+ "set recipe_click = recipe_click + 1 "
							+ "where recipe_no=?";
		Object[] param = {recipeNo};
		return jdbcTemplate.update(sql,param) > 0;
	}

	@Override
	public List<RecipeDto> adminList(RecipeListSearchVO vo) {
		return sqlSession.selectList("recipe.adminList", vo);
	}

	@Override
	public RecipeDto adminDetail(int recipeNo) {
		return sqlSession.selectOne("recipe.adminDetail", recipeNo);
	}
	
	//레시피 갯수 세기 위한 RowMapper
	private RowMapper<RecipeCountVO> countMapper = new RowMapper<RecipeCountVO>() {
		@Override
		public RecipeCountVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			RecipeCountVO recipeCountVO = new RecipeCountVO();
			recipeCountVO.setRecipeNo(rs.getInt("recipe_no"));
			recipeCountVO.setRecipeTitle(rs.getString("recipe_title"));
			recipeCountVO.setRecipeNick(rs.getString("recipe_nick"));
			recipeCountVO.setRecipeInfo(rs.getString("recipe_info"));
			recipeCountVO.setRecipeClick(rs.getInt("recipe_click"));
			recipeCountVO.setRecipeLike(rs.getInt("recipe_like"));
			recipeCountVO.setRecipeHashtag(rs.getString("recipe_hashtag"));
			recipeCountVO.setRecipeWritetime(rs.getDate("recipe_writetime"));
			recipeCountVO.setRecipeEdittime(rs.getDate("recipe-edittime"));
			recipeCountVO.setRecipeDifficulty(rs.getString("recipe_difficulty"));
			return recipeCountVO;
		}
	};
	
	//레시피 리스트 조회 위한 RowMapper
	private RowMapper<RecipeListVO> recipeMapper = new RowMapper<>() {	
		@Override
		public RecipeListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			return RecipeListVO.builder()
					.recipeNo(rs.getInt("recipe_no"))
					.recipeNick(rs.getString("recipe_nick"))
					.recipeTitle(rs.getString("recipe_title"))
					.recipeInfo(rs.getString("recipe_info"))
					.recipeTime(rs.getInt("recipe_time"))
					.recipeClick(rs.getInt("recipe_click"))
					.recipeLike(rs.getInt("recipe_like"))
					.recipeHashtag(rs.getString("recipe_hashtag"))
					.recipeWritetime(rs.getDate("recipe_writetime"))
					.recipeDifficulty(rs.getString("recipe_difficulty"))					
					.ingredientName(rs.getString("ingredient_name"))				
					.build();
		}
	};
	//재료별 레시피 리스트 출력
	@Override
	public List<RecipeListVO> recipeList(String ingredientName) {
		String sql = "select R.* ,RI.recipe_ingredient_name from recipe R inner join recipe_ingredient RI "
								+"on R.recipe_no=RI.recipe_no where recipe_ingredient_name=?";
		Object[] param = new Object[] {ingredientName};
		return jdbcTemplate.query(sql, recipeMapper, param);
	}

	//재료별 레시피 갯수 출력
	@Override
	public List<RecipeCountVO> selectRecipeList() {
		String sql = "select COUNT(*) cnt from recipe R inner join recipe_ingredient RI "
						+"on R.recipe_no=RI.recipe_no where recipe_ingredient_name=?";
		return jdbcTemplate.query(sql,  countMapper);
	}

}


