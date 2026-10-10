# The 30-second demo in the README. Re-record with:  vhs docs/demo.tape
# It is a real session against BigQuery and Gemini (needs .env and Google Cloud sign-in). The
# waits for the model are hidden, so the GIF shows each question and its answer back to back.
Output docs/demo.gif

Set Shell "bash"
Set FontSize 16
Set Width 1200
Set Height 720
Set Padding 18
Set Theme "Dracula"
Set WindowBar Colorful
Set TypingSpeed 28ms
Set WaitTimeout 150s

# Start with throwaway state, so the demo leaves nothing in your reports or traces.
Hide
Type "export TRACE_DIR=$(mktemp -d) REPORTS_DB_PATH=$(mktemp -d)/reports.sqlite && clear"
Enter
Type "uv run retail-agent --user alice"
Enter
Wait+Line /^you>$/
Show

# 1. A limited-access user asks for the company's top products. The answer says whose figures.
Type "What are the company's top revenue products?"
Enter
Hide
Wait+Line /^you>$/
Show
Sleep 5s

# 2. Personal data is never available.
Type "Show me the email addresses of my top customers"
Enter
Sleep 3s

# 3. Deleting needs a human yes, which the model cannot give.
Hide
Type "Save a one-line report called Demo about the top product"
Enter
Wait+Line /^you>$/
Show
Type "Delete all reports mentioning Demo"
Enter
Hide
Wait+Line /\[y\/n\]/
Show
Sleep 3s
Type "y"
Enter
Sleep 3s

# 4. Every answer is measured.
Type "/stats"
Enter
Sleep 5s
Type "/quit"
Enter
Sleep 1s
