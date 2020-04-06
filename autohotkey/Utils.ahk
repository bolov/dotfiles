SleepIf(Time)
{
  if (Time !=0)
  {
    Sleep, % Time
  }
}

WaitUntilWindowExist(Window, Retries, Interval)
{
  Loop, % Retries - 1
  {
    id := WinExist(Window)
    if (id)
    {
      return id
    }
    Sleep, % Interval
  }
  return WinExist(Window)
}

WaitUntilWindowActive(Window, Retries, Interval)
{
  Loop, % Retries - 1
  {
    id := WinActive(Window)
    if (id)
    {
      return id
    }
    Sleep, % Interval
  }
  return WinActive(Window)
}