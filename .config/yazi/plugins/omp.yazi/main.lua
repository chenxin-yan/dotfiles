local save = ya.sync(function(st, cwd, output)
	if cx.active.current.cwd == Url(cwd) then
		st.output = output
		ya.render()
	end
end)

local default_config = "~/.config/ohmyposh/cyan.omp.toml"

local get_config = ya.sync(function(st)
	return st.config
end)

return {
	setup = function(st, args)
		Header:children_remove(1, Header.LEFT)
		Header:children_add(function()
			return ui.Line.parse(st.output or "")
		end, 1000, Header.LEFT)

		st.config = default_config
		if args ~= nil and args.config ~= nil then
			st.config = args.config
		end

		local callback = function()
			local cwd = cx.active.current.cwd
			if st.cwd ~= cwd then
				st.cwd = cwd
				ya.manager_emit("plugin", { st._id, ya.quote(tostring(cwd), true) })
			end
		end

		ps.sub("cd", callback)
		ps.sub("tab", callback)
	end,

	entry = function(_, job)
		local output = Command("oh-my-posh")
			:arg({
				"print",
				"primary",
				"--no-status",
				"-c",
				get_config(),
			})
			:cwd(job.args[1])
			:output()
		if output then
			save(job.args[1], output.stdout:gsub("^%s+", ""))
		end
	end,
}
