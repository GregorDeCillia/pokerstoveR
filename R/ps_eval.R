anf <- function(x)
	as.numeric(as.character(x))

aif <- function(x)
	as.integer(as.character(x))

#' Evaluate hand equities
#'
#' This function calls `ps-eval` via [system] and uses string manipulation to convert
#' the output into a tidy dataframe.
#'
#' @param ... Hands to be evaluated
#' @param board The board
#' @param verbose If `TRUE`, print the raw output of ps-eval to the
#'   screen. Default is `FALSE`.
#'
#' @return A dataframe with the following columns
#'
#' * **hand**: One of the hands specified in `...`
#' * **equity**: The equity of the hand in percent
#' * **wins**: number of wins in the iteration through the possibility space
#' * **ties**: number of wins that have to be added to **wins** in order to respect
#'   ties in the equity calculation. For the evaluation of two hands, this will
#'   be half the number of ties.
#'
#' @examples
#' # ---------------- preflop --------------- #
#'
#' ps_eval("AcAs", "2h7d")
#' ps_eval("2h2s", "TdJd", "As7s")
#'
#' # ----------------- flop ----------------- #
#'
#' ps_eval("AcAs", "2h7d", board = "2c2d2s")
#'
#' # ----------------- turn ----------------- #
#'
#' ## 2 live overcars
#' ps_eval("2d2h", "AsKs", board = "4h5h6sTd")
#'
#' ## open ended straight flush draw
#' ps_eval("AdAh", "6s7s", board = "4s5s2hTh")
#'
#' # ----------------- river ---------------- #
#'
#' ps_eval("AdAh", "6s7s", board = "4s5s2hThAc")
#' @importFrom dplyr mutate select
#' @importFrom stringr str_extract_all
#' @importFrom magrittr %>% %T>%
#'
#' @export
ps_eval <- function(..., board = NULL, verbose = FALSE) {
	verify_ps_installed()

	. <- equity <- wins <- ties <- NULL

	if (length(list(...)) < 2)
		stop("submit at least two hands")

	cmdstr <- paste("ps-eval", ...)
	if (!is.null(board))
		cmdstr <- paste(cmdstr, "--board", board)

	cmdstr %>% 
		## process input
		system(intern = TRUE) %T>%
		## echo output if verbose is TRUE
		(function(x) { if(verbose) cat(x, sep = "\n") }) %>%
		## process string output
		substr(15, 100) %>%
		str_extract_all("\\(?[0-9,.]+\\)?") %>%
		lapply(function(hand) {
			hand <- sub("(", "", hand, fixed = TRUE)
			hand <- sub(")", "", hand, fixed = TRUE)
		}) %>%
		## tidy up the resulting table
		as.data.frame() %>% t %>% as.data.frame() %>%
		select(1:3) %>% `names<-`(c("equity", "wins", "ties")) %>%
		`rownames<-`(NULL) %>%
		cbind(data.frame(hand = c(...)), .) %>%
		mutate(equity = anf(equity), wins = aif(wins), ties = anf(ties))
}
