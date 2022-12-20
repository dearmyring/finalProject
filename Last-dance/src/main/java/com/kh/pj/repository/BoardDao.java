package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.MemberDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.vo.BoardListSearchVO;
import com.kh.pj.vo.BoardListVO;
import com.kh.pj.vo.ListSearchVO;
import com.kh.pj.vo.ListSearchVO2;

public interface BoardDao {
	
	int sequence();//시퀀스 발행 메소드
	
	public List<BoardListVO> boardList(BoardListSearchVO vo);
	
	public void write(BoardDto boardDto);
	boolean edit(BoardDto boardDto);
	boolean delete(int boardNo);
	
	public void updatePoint(MemberDto memberDto);//회원 포인트 업데이트
	public void deletePoint(MemberDto memberDto);//회원 포인트 삭제
	public int boardCNT(MemberDto memberDto);//유저 게시판 등록 카운트
	public int replyCNT(MemberDto memberDto);//댓글 수 등록 카운트
	
	
	//상세,좋아요
	public BoardListVO selectOne(int boardNo);
	BoardListVO click(int boardNo);
	boolean updateClickCount(int boardNo);

	//첨부파일 관련 기능
		void connectAttachment(int boardOriginNo, int boardAttachmentNo);
		int insert2(BoardDto boardDto);
		
	//관리자 유저게시판 조회
		public List<BoardDto> adminList(ListSearchVO2 vo2);
	//관리자 유저게시글 블라인드
		boolean blind(BoardDto boardDto);
}
