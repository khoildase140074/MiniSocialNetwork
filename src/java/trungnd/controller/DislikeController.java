/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trungnd.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import trungnd.blo.CommentBLO;
import trungnd.blo.EmotionBLO;
import trungnd.db.Account;
import trungnd.db.Article;
import trungnd.db.Comment;

/**
 *
 * @author HOME
 */
public class DislikeController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String show_acc = request.getParameter("txtAcc");
            String show_accName = request.getParameter("txtAccName");
            String show_arcDate = request.getParameter("txtArcDate");
            String show_arcTitle = request.getParameter("txtArcTitle");
            String show_arcDes = request.getParameter("txtArcDes");
            String show_arcImage = request.getParameter("txtImageArt");
            String article_ID = request.getParameter("txtArticleID");
            
            request.setAttribute("txtAcc", show_acc);
            request.setAttribute("txtAccName", show_accName);
            request.setAttribute("txtArcDate", show_arcDate);
            request.setAttribute("txtArcTitle", show_arcTitle);
            request.setAttribute("txtArcDes", show_arcDes);
            request.setAttribute("txtArticleID", article_ID);
            System.out.println(show_arcImage);
            request.setAttribute("txtArcImage", show_arcImage);
            
            HttpSession session = request.getSession();
            Account accID = (Account) session.getAttribute("ACCOUNT");
            Article articleID = (Article) session.getAttribute("ARTICLE");;
            
            CommentBLO blo = new CommentBLO();
            EmotionBLO blo_emo = new EmotionBLO();
            String emotionID = articleID + "_" + accID;
            boolean check = blo_emo.createEmotion(emotionID, false, accID, articleID);
            if (check) {
                System.out.println("Success");
            } else {
                System.out.println("Unsuccess");
            }
            boolean statusCmt = true;
            List<Comment> result = blo.showComment(articleID, statusCmt);
            if (result != null) {
                request.setAttribute("LIST_COMMENT", result);
            } 
            List<String> like = blo_emo.countEmotionLike(articleID, true);
            List<String> dislike = blo_emo.countEmotionDislike(articleID, false);
            System.out.println(like + " " + dislike);
            request.setAttribute("LIKE", String.valueOf(like));
            request.setAttribute("DISLIKE", String.valueOf(dislike));
        } catch (Exception e) {
            log("ERROR at PostCommentController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("showDetails.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
