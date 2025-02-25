module Day02Pt1 where

day02Pt1 :: IO ()
day02Pt1 = do
  contents <- readFile "data/day2-input.txt"
  let linesOfFile = lines contents
  let lineSplits = map stringToIntArr linesOfFile
  let safeCount = countSafe lineSplits
  print safeCount

-- convert string to int array
stringToIntArr :: String -> [Int]
stringToIntArr x = map read $ words x :: [Int]

-- count number of safe lines
countSafe :: [[Int]] -> Int
countSafe [] = 0
countSafe (x:xs) | isSafe x = 1 + countSafe xs
                  | otherwise = countSafe xs

-- check if a line is safe
isSafe :: [Int] -> Bool
isSafe x = isAsc x || isDesc x

-- check if numbers are ascending
isAsc :: [Int] -> Bool
isAsc = checkRule (\ x1 x2 -> x2 > x1 && x2 - x1 >= 1 && x2 - x1 <= 3)

-- check if numbers are descending
isDesc :: [Int] -> Bool
isDesc = checkRule (\ x1 x2 -> x2 < x1 && x1 - x2 >= 1 && x1 - x2 <= 3)

-- apply direction check to line
checkRule :: (Int -> Int -> Bool) -> [Int] -> Bool
checkRule _ [] = True
checkRule _ [_] = True
checkRule f (x1:x2:xs) | f x1 x2 = checkRule f (x2 : xs)
                        | otherwise = False