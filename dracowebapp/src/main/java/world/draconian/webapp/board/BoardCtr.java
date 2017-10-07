package world.draconian.webapp.board;

import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import world.draconian.webapp.board.BoardSvc;
import world.draconian.webapp.board.BoardReplyVO;
import world.draconian.webapp.board.BoardVO;
import world.draconian.webapp.common.SearchVO;
import world.draconian.webapp.common.file.FileUtil;
import world.draconian.webapp.common.file.FileVO;

@Controller 
public class BoardCtr {

    @Autowired
    private BoardSvc boardSvc;
    @Autowired
    private BoardGroupSvc boardGroupSvc;
    

    /**
     * 리스트.
     */
    @RequestMapping(value = "/board/boardList")
    public String boardList(SearchVO searchVO, ModelMap modelMap) {
        
        BoardGroupVO bgInfo = boardGroupSvc.selectBoardGroupOne4Used(searchVO.getBgno());
        if (bgInfo == null) {
            return "board/BoardGroupFail";
        }
        
        searchVO.pageCalculate( boardSvc.selectBoardCount(searchVO) ); // startRow, endRow

        List<?> listview  = boardSvc.selectBoardList(searchVO);
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        modelMap.addAttribute("bgInfo", bgInfo);
        
        return "board/BoardList";
    }
    
    /** 
     * 글 쓰기. 
     */
    @RequestMapping(value = "/board/boardForm")
    public String boardForm(HttpServletRequest request, ModelMap modelMap) {
        String bgno = request.getParameter("bgno");
        String brdno = request.getParameter("brdno");
        
        if (brdno != null) {
            BoardVO boardInfo = boardSvc.selectBoardOne(brdno);
            List<?> listview = boardSvc.selectBoardFileList(brdno);
        
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
            bgno = boardInfo.getBgno();
        }
        BoardGroupVO bgInfo = boardGroupSvc.selectBoardGroupOne4Used(bgno);
        if (bgInfo == null) {
            return "board/BoardGroupFail";
        }
        
        modelMap.addAttribute("bgno", bgno);
        modelMap.addAttribute("bgInfo", bgInfo);
        
        return "board/BoardForm";
    }
    
    /**
     * 글 저장.
     */
    @RequestMapping(value = "/board/boardSave")
    public String boardSave(HttpServletRequest request, BoardVO boardInfo) {
        String[] fileno = request.getParameterValues("fileno");
        
        FileUtil fs = new FileUtil();
        List<FileVO> filelist = fs.saveAllFiles(boardInfo.getUploadfile());

        boardSvc.insertBoard(boardInfo, filelist, fileno);

        return "redirect:/boardList?bgno=" + boardInfo.getBgno();
    }

    /**
     * 글 읽기.
     */
    @RequestMapping(value = "/board/boardRead")
    public String boardRead(HttpServletRequest request, ModelMap modelMap) {
        String brdno = request.getParameter("brdno");
        
        boardSvc.updateBoardRead(brdno);
        BoardVO boardInfo = boardSvc.selectBoardOne(brdno);
        List<?> listview = boardSvc.selectBoardFileList(brdno);
        List<?> replylist = boardSvc.selectBoardReplyList(brdno);

        BoardGroupVO bgInfo = boardGroupSvc.selectBoardGroupOne4Used(boardInfo.getBgno());
        if (bgInfo == null) {
            return "board/BoardGroupFail";
        }
        
        modelMap.addAttribute("boardInfo", boardInfo);
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("replylist", replylist);
        modelMap.addAttribute("bgInfo", bgInfo);
        
        return "board/BoardRead";
    }
    
    /**
     * 글 삭제.
     */
    @RequestMapping(value = "/board/boardDelete")
    public String boardDelete(HttpServletRequest request) {
        String brdno = request.getParameter("brdno");
        String bgno = request.getParameter("bgno");
        
        boardSvc.deleteBoardOne(brdno);
        
        return "redirect:/boardList?bgno=" + bgno;
    }

    
    /**
     * 댓글 저장.
     */
    @RequestMapping(value = "/board/boardReplySave")
    public String boardReplySave(HttpServletRequest request, BoardReplyVO boardReplyInfo, ModelMap modelMap) {
        
        boardSvc.insertBoardReply(boardReplyInfo);

        modelMap.addAttribute("replyInfo", boardReplyInfo);
        
        return "board/BoardReadAjax4Reply";        
    }
    
    /**
     * 댓글 삭제.
     */
    @RequestMapping(value = "/board/boardReplyDelete")
    public void boardReplyDelete(HttpServletResponse response, BoardReplyVO boardReplyInfo) {
        
        ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json;charset=UTF-8");
        
        try {
            if (!boardSvc.deleteBoardReply(boardReplyInfo.getReno()) ) {
                response.getWriter().print(mapper.writeValueAsString("Fail"));
            } else {
                response.getWriter().print(mapper.writeValueAsString("OK"));
            }
        } catch (IOException ex) {
            System.out.println("오류: 댓글 삭제에 문제가 발생했습니다.");
        }
    }
   
}
