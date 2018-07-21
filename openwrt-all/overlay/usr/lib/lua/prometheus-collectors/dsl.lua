local function scrape()
	local has_dsl = fs.access("/etc/init.d/dsl_control")
	if has_dsl then
		local dsl_info = metric("dsl_info","gauge")
		local dsl_line_info = metric("dsl_line_info", "gauge")
		local dsl_uptime = metric("dsl_uptime", "gauge")
		local dsl_up = metric("dsl_up", "counter")
		local dsl_data_rate_up = metric("dsl_data_rate_up", "gauge")
		local dsl_data_rate_down = metric("dsl_data_rate_down", "gauge")
		local dsl_max_data_rate_up = metric("dsl_max_data_rate_up", "gauge")
		local dsl_max_data_rate_down = metric("dsl_max_data_rate_down", "gauge")
		local dsl_errors_total = metric("dsl_errors_total", "counter")
		local dsl_error_seconds_total = metric("dsl_error_seconds_total", "counter")

		local dsl_stat = luci.sys.exec("/etc/init.d/dsl_control lucistat")

		-- dsl hardware/firmware information
		dsl_info({
			atuc_vendor_id = dsl_stat.atuc_vendor_id,
			atuc_system_vendor_id = dsl_stat.atuc_system_vendor_id,
			chipset = dsl_stat.chipset,
			firmware_version = dsl_stat.firmware_version,
			api_version = dsl_stat.api_version,
		}, 1)

		-- dsl line settings information
		dsl_line_info({
			xtse1   = dsl_stat.xtse1,
			xtse2   = dsl_stat.xtse2,
			xtse3   = dsl_stat.xtse3,
			xtse4   = dsl_stat.xtse4,
			xtse5   = dsl_stat.xtse5,
			xtse6   = dsl_stat.xtse6,
			xtse7   = dsl_stat.xtse7,
			xtse8   = dsl_stat.xtse8,
			annex   = dsl_stat.annex_s,
			mode    = dsl_stat.line_mode_s,
			profile = dsl_stat.profile_s,
		}, 1)

		-- dsl up is 1 if the line is up and running
		if dls_stat.line_state == "UP" then
			dsl_up({}, 1)
		else
			dsl_up({}, 0)
		end

		-- dsl line status data
		dsl_uptime({}, dsl_stat.line_uptime)

		-- dsl performance data
		dsl_data_rate_up({}, dsl_stat.data_rate_up)
		dsl_data_rate_down({}, dsl_stat.data_rate_down)
		dsl_max_data_rate_up({}, dsl_stat.max_data_rate_up)
		dsl_max_data_rate_down({}, dsl_stat.max_data_rate_down)

		-- dsl errors
		dsl_error_seconds_total({err="forward error correction",loc="near"}, dsl_stat.errors_fec_near)
		dsl_error_seconds_total({err="forward error correction",loc="far"}, dsl_stat.errors_fec_far)
		dsl_error_seconds_total({err="errored",loc="near"}, dsl_stat.errors_es_near)
		dsl_error_seconds_total({err="errored",loc="far"}, dsl_stat.errors_es_near)
		dsl_error_seconds_total({err="severely errored",loc="near"}, dsl_stat.errors_ses_near)
                dsl_error_seconds_total({err="severely errored",loc="near"}, dsl_stat.errors_ses_near)
		dsl_error_seconds_total({err="loss of signal",loc="near"}, dsl_stat.errors_loss_near)
		dsl_error_seconds_total({err="loss of signal",loc="far"}, dsl_stat.errors_loss_far)
		dsl_error_seconds_total({err="unavailable",loc="near"}, dsl_stat.errors_uas_near)
		dsl_error_seconds_total({err="unavailable",loc="far"}, dsl_stat.errors_uas_far)
		dsl_errors_total({err="header error code error",loc="near"}, dsl_stat.errors_hec_near)
		dsl_errors_total({err="header error code error",loc="far"}, dsl_stat.errors_hec_far)
		dsl_errors_total({err="",loc="near"},0)
	end
end

return { scrape = scrape }
