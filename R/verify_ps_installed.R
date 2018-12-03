#' Check if ps-eval is available
#'
#' This function throws an error if `system("ps-eval")` is not available.
#' The error message indicates to the user where installation instructions 
#' for pokerstove can be found.
#' 
#' @return `ìnvisible(NULL)` if `ps-eval` is available. Otherwise, an error
#'   is thrown.
#'
#' @export
verify_ps_installed <- function() {
	is_installed <- suppressWarnings(
		system("ps-eval", ignore.stdout = TRUE, ignore.stderr = TRUE) != 127
	)
	if (!is_installed)
		stop("ps-eval is not available in your system. Please follwo the instructions ",
		     "on https://github.com/andrewprock/pokerstove anid make sure the executable ",
		     "is part of your PATH.")
	invisible(NULL)
}
