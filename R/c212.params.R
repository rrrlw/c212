# c212
# Default params
# R. Carragher
# Date: 20/08/2020

Id <- "$Id: c212.params.R,v 1.4 2020/08/31 10:03:45 clb13102 Exp clb13102 $"

c212.sim.control.params = function(trial.data, model = "1a") {

	if (model == "1a") {
		sim_param = c212.1a.sim.control.params(trial.data)
	}
	else {
		sim_param = c212.BB.sim.control.params(trial.data)
	}

	sim_param
}

c212.1a.sim.control.params = function(trial.data) {

	if (is.character(trial.data)) {
		file = trial.data
		trial.data <- read.table(file, header=TRUE, stringsAsFactors = FALSE)
	}

	trial.data = trial.data[trial.data$Group == 2,]
	n = nrow(trial.data)

    facs <- sapply(trial.data, is.factor)
    trial.data[facs] <- sapply(trial.data[facs], as.character)

	if ("Interval" %in% names(trial.data)) {

		p_SLICE = "w"
		v_SLICE = 1.0
		c_SLICE = 6

		p_MH = "sigma_MH"
		v_MH = 0.2
		c_MH = 0.0

		sp1 = data.frame(type = "SLICE", variable = "gamma",
				Interval = trial.data$Interval,
				I_index = trial.data$I_index, B = trial.data$B,
				AE = trial.data$AE,
				param = p_SLICE, value = v_SLICE, control = c_SLICE,
				stringsAsFactors = FALSE)

		sp2 = data.frame(type = "SLICE", variable = "theta",
				Interval = trial.data$Interval,
				I_index = trial.data$I_index, B = trial.data$B,
				AE = trial.data$AE,
				param = p_SLICE, value = v_SLICE, control = c_SLICE,
				stringsAsFactors = FALSE)

		sp3 = data.frame(type = "MH", variable = "gamma",
				Interval = trial.data$Interval,
				I_index = trial.data$I_index, B = trial.data$B,
				AE = trial.data$AE, 
				param = p_MH, value = v_MH, control = c_MH,
				stringsAsFactors = FALSE)

		sp4 = data.frame(type = "MH", variable = "theta",
				Interval = trial.data$Interval,
				I_index = trial.data$I_index, B = trial.data$B,
				AE = trial.data$AE, 
				param = p_MH, value = v_MH, control = c_MH,
				stringsAsFactors = FALSE)
	}
	else {

		p_SLICE = "w"
		v_SLICE = 1.0
		c_SLICE = 6

		p_MH = "sigma_MH"
		v_MH = 0.35
		c_MH = 0.0

		sp1 = data.frame(type = "SLICE", variable = "gamma",
								B = trial.data$B,
								AE = trial.data$AE, 
								param = p_SLICE, value = v_SLICE, control = c_SLICE,
								stringsAsFactors = FALSE)

		sp2 = data.frame(type = "SLICE", variable = "theta",
								B = trial.data$B,
								AE = trial.data$AE, 
								param = p_SLICE, value = v_SLICE, control = c_SLICE,
								stringsAsFactors = FALSE)

		sp3 = data.frame(type = "MH", variable = "gamma",
								B = trial.data$B,
								AE = trial.data$AE, 
								param = p_MH, value = v_MH, control = c_MH,
								stringsAsFactors = FALSE)

		sp4 = data.frame(type = "MH", variable = "theta",
								B = trial.data$B,
								AE = trial.data$AE, 
								param = p_MH, value = v_MH, control = c_MH,
								stringsAsFactors = FALSE)
	}
	sim_params = rbind(sp1, sp2, sp3, sp4)

	sim_params
}

c212.BB.sim.control.params = function(trial.data) {

	if (is.character(trial.data)) {
		file = trial.data
		trial.data <- read.table(file, header=TRUE, stringsAsFactors = FALSE)
	}

    facs <- sapply(trial.data, is.factor)
    trial.data[facs] <- sapply(trial.data[facs], as.character)

	trial.data = trial.data[trial.data$Group == 2,]

	if ("Interval" %in% names(trial.data)) {

		v_sigma_MH_gamma = 0.2
		v_sigma_MH_theta = 0.15

		v_w = 1
		v_w_control = 6
		v_sigma = 3

		sp1 = data.frame(type = "MH", variable = "gamma",
								Interval = trial.data$Interval,
								I_index = trial.data$I_index,
								B = trial.data$B,
								AE = trial.data$AE, 
								param = "sigma_MH_gamma", value = v_sigma_MH_gamma,
								control = 0,
								stringsAsFactors = FALSE)

		sp2 = data.frame(type = "MH", variable = "theta",
								Interval = trial.data$Interval,
								I_index = trial.data$I_index,
								B = trial.data$B,
								AE = trial.data$AE, 
								param = "sigma_MH_theta", value = v_sigma_MH_theta,
								control = 0,
								stringsAsFactors = FALSE)

		sp3 = data.frame(type = "SLICE", variable = "gamma",
								Interval = trial.data$Interval,
								I_index = trial.data$I_index,
								B = trial.data$B,
								AE = trial.data$AE, 
								param = "w_gamma", value = v_w,
								control = v_w_control,
								stringsAsFactors = FALSE)

		sp4 = data.frame(type = "MH", variable = "alpha",
								Interval = unique(trial.data$Interval),
								I_index = unique(trial.data$I_index),
								B = NA,
								AE = NA,
								param = "sigma_MH_alpha", value = v_sigma,
								control = 0,
								stringsAsFactors = FALSE)

		sp5 = data.frame(type = "SLICE", variable = "alpha",
								Interval = unique(trial.data$Interval),
								I_index = unique(trial.data$I_index),
								B = NA,
								AE = NA,
								param = "w_alpha", value = v_w,
								control = v_w_control,
								stringsAsFactors = FALSE)

		sp6 = data.frame(type = "MH", variable = "beta",
								Interval = unique(trial.data$Interval),
								I_index = unique(trial.data$I_index),
								B = NA,
								AE = NA,
								param = "sigma_MH_beta", value = v_sigma,
								control = 0,
								stringsAsFactors = FALSE)

		sp7 = data.frame(type = "SLICE", variable = "beta",
								Interval = unique(trial.data$Interval),
								I_index = unique(trial.data$I_index),
								B = NA,
								AE = NA,
								param = "w_beta", value = v_w,
								control = v_w_control,
								stringsAsFactors = FALSE)


		sim_params = rbind(sp1, sp2, sp3, sp4, sp5, sp6, sp7)

	}
	else {

		v_sigma_MH_gamma = 0.2
		v_sigma_MH_theta = 0.2

		v_w_gamma = 1
		v_w_gamma_control = 6

		sp1 = data.frame(type = "MH", variable = "gamma",
								B = trial.data$B,
								AE = trial.data$AE, 
								param = "sigma_MH_gamma", value = v_sigma_MH_gamma,
								control = 0,
								stringsAsFactors = FALSE)

		sp2 = data.frame(type = "MH", variable = "theta",
								B = trial.data$B,
								AE = trial.data$AE, 
								param = "sigma_MH_theta", value = v_sigma_MH_theta,
								control = 0,
								stringsAsFactors = FALSE)

		sp3 = data.frame(type = "SLICE", variable = "gamma",
								B = trial.data$B,
								AE = trial.data$AE, 
								param = "w_gamma", value = v_w_gamma,
								control = v_w_gamma_control,
								stringsAsFactors = FALSE)

		sim_params = rbind(sp1, sp2, sp3)
	}

	sim_params
}

c212.global.sim.params <- function(trial.data, model = "BB", hier = 3) {

	if (is.null(model)) {
		return(NULL)
	}

	global.sim.params <- NULL

	if (model == "1a") {
		global.sim.params <- c212.1a.global.sim.params(trial.data, hier)
	}
	else if (model == "BB") {
		global.sim.params <- c212.BB.global.sim.params(trial.data, hier)
	}

	global.sim.params
}

c212.1a.global.sim.params <- function(trial.data, hier = 3) {

	if (is.character(trial.data)) {
		file = trial.data
		trial.data <- read.table(file, header=TRUE, stringsAsFactors = FALSE)
    }

	if (is.null(trial.data)) {
		return(NULL)
	}

	global.sim.params <- NULL

	if ("Interval" %in% names(trial.data)) {
		global.sim.params = data.frame(type = c("MH", "SLICE"),
							param = c("sigma_MH", "w"),
                           	value = c(0.2,1),
							control = c(0,6), stringsAsFactors = FALSE)
	}
	else {
		#EOT 1a
		global.sim.params = data.frame(type = c("MH", "SLICE"),
							param = c("sigma_MH", "w"),
							value = c(0.35,1),
							control = c(0,6), stringsAsFactors = FALSE)
	}

	global.sim.params
}

c212.BB.global.sim.params <- function(trial.data, hier = 3) {

	if (is.character(trial.data)) {
		file = trial.data
		trial.data <- read.table(file, header=TRUE, stringsAsFactors = FALSE)
    }

	if (is.null(trial.data)) {
		return(NULL)
	}


	global.sim.params <- NULL

	if ("Interval" %in% names(trial.data)) {
		if (hier == 3) {
			global.sim.params = data.frame(type = c("MH", "MH", "MH", "MH",
					"SLICE", "SLICE", "SLICE"),
                    param = c("sigma_MH_alpha", "sigma_MH_beta",
								"sigma_MH_gamma", "sigma_MH_theta",
								"w_alpha", "w_beta", "w_gamma"),
					value = c(3, 3, 0.2, 0.25, 1, 1, 1),
					control = c(0, 0, 0, 0, 6, 6, 6),
					stringsAsFactors = FALSE)
		}
		else if (hier == 2) {
			global.sim.params = data.frame(type = c("MH", "MH", "MH", "MH",
					"SLICE", "SLICE", "SLICE"),
					param = c("sigma_MH_alpha", "sigma_MH_beta",
								"sigma_MH_gamma", "sigma_MH_theta",
								"w_alpha", "w_beta", "w_gamma"),
					value = c(3, 3, 0.2, 0.5, 1, 1, 1),
					control = c(0, 0, 0, 0, 6, 6, 6),
					stringsAsFactors = FALSE)

		}
	}
	else {
		# EOT BB
		global.sim.params = data.frame(type = c("MH", "MH", "MH", "MH",
								"SLICE", "SLICE", "SLICE"),
								param = c("sigma_MH_alpha", "sigma_MH_beta",
								 "sigma_MH_gamma", "sigma_MH_theta",
								"w_alpha", "w_beta", "w_gamma"),
								value = c(3, 3, 0.2, 0.2, 1, 1, 1),
								control = c(0, 0, 0, 0, 6, 6, 6),
								stringsAsFactors = FALSE)
	}

	global.sim.params
}

c212.hyper.params <- function(trial.data, model = "BB", hier = 3) {

	if (is.null(model)) {
		return(NULL)
	}

	hyper_params <- NULL

	if (model == "1a") {
		hyper_params <- c212.1a.hyper.params(trial.data, hier)
	}
	else if (model == "BB") {
		hyper_params <- c212.BB.hyper.params(trial.data, hier)
	}

	hyper_params
}

c212.1a.hyper.params <- function(trial.data, hier = 3) {

	if (is.character(trial.data)) {
		file = trial.data
		trial.data <- read.table(file, header=TRUE, stringsAsFactors = FALSE)
	}

	if (is.null(trial.data)) {
		return(NULL)
	}

	hyper_params <- NULL

	if ("Interval" %in% names(trial.data)) {
		if (hier == 3) {
			hyper_params = list(mu.gamma.0.0 = 0, tau2.gamma.0.0 = 10,
				mu.theta.0.0 = 0, tau2.theta.0.0 = 10, alpha.gamma.0.0 = 3,
				beta.gamma.0.0 = 1, alpha.theta.0.0 = 3, beta.theta.0.0 = 1,
				alpha.gamma = 3, beta.gamma = 1, alpha.theta = 3,
				beta.theta = 1)
		}
		else if (hier == 2) {
			 hyper_params = list(mu.gamma.0 = 0, tau2.gamma.0 = 10,
				mu.theta.0 = 0, tau2.theta.0 = 10, alpha.gamma = 3,
				beta.gamma = 1,
				alpha.theta = 3, beta.theta = 1)
		}
	}
	else {
		#EOT 1a
		hyper_params = list(mu.gamma.0.0 = 0, tau2.gamma.0.0 = 10,
			mu.theta.0.0 = 0, tau2.theta.0.0 = 10, alpha.gamma.0.0 = 3,
			beta.gamma.0.0 = 1, alpha.theta.0.0 = 3, beta.theta.0.0 = 1,
			alpha.gamma = 3, beta.gamma = 1, alpha.theta = 3,
			beta.theta = 1)
	}

	hyper_params
}

c212.BB.hyper.params <- function(trial.data, hier = 3) {

	if (is.character(trial.data)) {
		file = trial.data
		trial.data <- read.table(file, header=TRUE, stringsAsFactors = FALSE)
	}

	if (is.null(trial.data)) {
		return(NULL)
	}

	hyper_params <- NULL

	if ("Interval" %in% names(trial.data)) {
		if (hier == 3) {
			 hyper_params = list(mu.gamma.0.0 = 0, tau2.gamma.0.0 = 10,
				mu.theta.0.0 = 0, tau2.theta.0.0 = 10, alpha.gamma.0.0 = 3,
				beta.gamma.0.0 = 1, alpha.theta.0.0 = 3, beta.theta.0.0 = 1,
				alpha.gamma = 3, beta.gamma = 1, alpha.theta = 3,
				beta.theta = 1, lambda.alpha = 1.0, lambda.beta = 1.0)
		}
		else if (hier == 2) {
			hyper_params = list(mu.gamma.0 = 0, tau2.gamma.0 = 10,
				mu.theta.0 = 0, tau2.theta.0 = 10, alpha.gamma = 3,
				beta.gamma = 1, alpha.theta = 3,
				beta.theta = 1, alpha.pi = 1.1, beta.pi = 1.1)
		}
	}
	else {
		# EOT BB
		hyper_params = list(mu.gamma.0.0 = 0, tau2.gamma.0.0 = 10,
				mu.theta.0.0 = 0, tau2.theta.0.0 = 10, alpha.gamma.0.0 = 3,
				beta.gamma.0.0 = 1, alpha.theta.0.0 = 3, beta.theta.0.0 = 1,
				alpha.gamma = 3, beta.gamma = 1, alpha.theta = 3,
				beta.theta = 1, lambda.alpha = 1.0, lambda.beta = 1.0)
	}

	hyper_params
}
