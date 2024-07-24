import 'package:flutter/material.dart';
import 'dart:math';
import 'QuestionCompletionHistoryDB.dart';
import 'QuestionCompletionHistory.dart';
import 'popUpWindow.dart';


class DailyQuestionGenerator extends StatefulWidget {

  String username = "";

  DailyQuestionGenerator(this.username);

  @override
  _DailyQuestionGeneratorState createState() => _DailyQuestionGeneratorState();
}

class _DailyQuestionGeneratorState extends State<DailyQuestionGenerator> {
  String todayQuestion = "Press the button below to get today's random question.";
  final controller = TextEditingController();
  bool questionGenerated = false;
  
  void generateQuestion(){
    this.setState(() {
      if(!questionGenerated)
      {
        this.todayQuestion = Blind75QuestionBank().blind75QuestionMap.keys.elementAt(new Random().nextInt(Blind75QuestionBank().blind75QuestionMap.length));
        questionGenerated = true;
      }
      else
      {
        PopUpWindow().showPopUpWindow(context, "Error", "You have generated today's problem. Please come back tomorrow ^_^");
      }
    });
  }

  void completeQuestion(){
    if(questionGenerated == true) {
      QuestionCompletionHistoryDB().findQuestionByUsername(this.widget.username, this.todayQuestion).then((questionExistsInDatabase) {
        if(questionExistsInDatabase == true) {
          QuestionCompletionHistoryDB().incrementNumOfCompletion(this.widget.username, this.todayQuestion);
        } else {
          QuestionCompletionHistoryDB().create(question: this.todayQuestion, user: this.widget.username);
          QuestionCompletionHistoryDB().fetchByUsername(this.widget.username); 
        }
      });
    } else {
      PopUpWindow().showPopUpWindow(context, "Error", "You have not generate a question yet.");
    }
  }

  void directToLeetCode() {
    print(Blind75QuestionBank().blind75QuestionMap[this.todayQuestion]);
  }

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.center,
      child: Padding(padding: EdgeInsets.all(10),
        child:Column(
          children: <Widget>[
            TextField(
              controller: controller,
              enabled: false,
              decoration: InputDecoration(
                labelText: todayQuestion,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('Show Today\'s\ question'),
                  onPressed: this.generateQuestion
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  child: const Text('Complete on LeetCode!'),
                  onPressed: this.directToLeetCode
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  child: const Text('Completed Today\'s\ question'),
                  onPressed: this.completeQuestion
                )
              ]
            ),
            SizedBox(height: 10)
          ]
        )
      )
    ); 
  }
}

class Blind75QuestionBank {
  Map blind75QuestionMap = { "Contains Duplicate": "https://leetcode.com/problems/contains-duplicate/description/",
    "Valid Anagram": "https://leetcode.com/problems/valid-anagram/description/",
    "Two Sum": "https://leetcode.com/problems/two-sum/description/",
    "Group Anagram": "https://leetcode.com/problems/group-anagrams/description/",
    "Top K Frequent Elements": "https://leetcode.com/problems/top-k-frequent-elements/description/",
    "Encode and Decode Strings": "https://leetcode.com/problems/encode-and-decode-strings/description/",
    "Product of Array Except Self": "https://leetcode.com/problems/product-of-array-except-self/description/",
    "Longest Consecutive Sequence": "https://leetcode.com/problems/longest-consecutive-sequence/description/",
    "Valid Palindrome": "https://leetcode.com/problems/valid-palindrome/description/",
    "3Sum": "https://leetcode.com/problems/3sum/description/",
    "Container With Most Water": "https://leetcode.com/problems/container-with-most-water/description/",
    "Best Time to Buy and Sell Stock": "https://leetcode.com/problems/best-time-to-buy-and-sell-stock/description/",
    "Longest Substring Without Repeating Characters": "https://leetcode.com/problems/longest-substring-without-repeating-characters/description/",
    "Longest Repeating Character Replacement": "https://leetcode.com/problems/longest-repeating-character-replacement/description/",
    "Minimum Window Substring": "https://leetcode.com/problems/minimum-window-substring/description/",
    "Valid Parentheses": "https://leetcode.com/problems/valid-parentheses/description/",
    "Find Minimum in Rotated Sorted Array": "https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/description/",
    "Search in Rotated Sorted Array": "https://leetcode.com/problems/search-in-rotated-sorted-array/description/",
    "Reverse Linked List": "https://leetcode.com/problems/reverse-linked-list/description/",
    "Merge Two Sorted Lists": "https://leetcode.com/problems/merge-two-sorted-lists/description/",
    "Reorder List": "https://leetcode.com/problems/reorder-list/description/",
    "Remove Nth Node From End of List": "https://leetcode.com/problems/remove-nth-node-from-end-of-list/description/",
    "Linked List Cycle": "https://leetcode.com/problems/linked-list-cycle/description/",
    "Merge k Sorted Lists": "https://leetcode.com/problems/merge-k-sorted-lists/description/",
    "Invert Binary Tree": "https://leetcode.com/problems/invert-binary-tree/description/",
    "Maximum Depth of Binary Tree": "https://leetcode.com/problems/maximum-depth-of-binary-tree/description/",
    "Same Tree": "https://leetcode.com/problems/same-tree/description/",
    "Subtree of Another Tree": "https://leetcode.com/problems/subtree-of-another-tree/description/",
    "Lowest Common Ancestor of a Binary Search Tree": "https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/description/",
    "Binary Tree Level Order Traversal": "https://leetcode.com/problems/binary-tree-level-order-traversal/description/",
    "Validate Binary Search Tree": "https://leetcode.com/problems/validate-binary-search-tree/description/",
    "Kth Smallest Element in a BST": "https://leetcode.com/problems/kth-smallest-element-in-a-bst/description/",
    "Construct Binary Tree from Preorder and Inorder Traversal": "https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/description/",
    "Binary Tree Maximum Path Sum": "https://leetcode.com/problems/binary-tree-maximum-path-sum/description/",
    "Serialize and Deserialize Binary Tree": "https://leetcode.com/problems/serialize-and-deserialize-binary-tree/description/",
    "Find Median from Data Stream": "https://leetcode.com/problems/find-median-from-data-stream/description/",
    "Combination Sum": "https://leetcode.com/problems/combination-sum/description/",
    "Word Search": "https://leetcode.com/problems/word-search/description/",
    "Implement Trie (Prefix Tree)": "https://leetcode.com/problems/implement-trie-prefix-tree/description/",
    "Design Add and Search Words Data Structure": "https://leetcode.com/problems/design-add-and-search-words-data-structure/description/",
    "Word Search II": "https://leetcode.com/problems/word-search-ii/description/",
    "Number of Islands": "https://leetcode.com/problems/number-of-islands/description/",
    "Clone Graph": "https://leetcode.com/problems/clone-graph/description/",
    "Pacific Atlantic Water Flow": "https://leetcode.com/problems/pacific-atlantic-water-flow/description/",
    "Course Schedule": "https://leetcode.com/problems/course-schedule/description/",
    "Graph Valid Tree": "https://leetcode.com/problems/graph-valid-tree/description/",
    "Number of Connected Components In An Undirected Graph": "https://leetcode.com/problems/number-of-connected-components-in-an-undirected-graph/description/",
    "Alien Dictionary": "https://leetcode.com/problems/alien-dictionary/description/",
    "Climbing Stairs": "https://leetcode.com/problems/climbing-stairs/description/",
    "House Robber": "https://leetcode.com/problems/house-robber/description/",
    "House Robber II": "https://leetcode.com/problems/house-robber-ii/description/",
    "Longest Palindromic Substring": "https://leetcode.com/problems/longest-palindromic-substring/description/",
    "Palindromic Substrings": "https://leetcode.com/problems/palindromic-substrings/description/",
    "Decode Ways": "https://leetcode.com/problems/decode-ways/description/",
    "Coin Change": "https://leetcode.com/problems/coin-change/description/",
    "Maximum Product Subarray": "https://leetcode.com/problems/maximum-product-subarray/description/",
    "Word Break": "https://leetcode.com/problems/word-break/description/",
    "Longest Increasing Subsequence": "https://leetcode.com/problems/longest-increasing-subsequence/description/",
    "Unique Paths": "https://leetcode.com/problems/unique-paths/description/",
    "Longest Common Subsequence": "https://leetcode.com/problems/longest-common-subsequence/description/",
    "Maximum Subarray": "https://leetcode.com/problems/maximum-subarray/description/",
    "Jump Game": "https://leetcode.com/problems/jump-game/description/",
    "Insert Interval": "https://leetcode.com/problems/insert-interval/description/",
    "Merge Intervals": "https://leetcode.com/problems/merge-intervals/description/",
    "Non-overlapping Intervals": "https://leetcode.com/problems/non-overlapping-intervals/description/",
    "Meeting Rooms": "https://leetcode.com/problems/meeting-rooms/description/",
    "Meeting Rooms II": "https://leetcode.com/problems/meeting-rooms-ii/description/",
    "Rotate Image": "https://leetcode.com/problems/rotate-image/description/",
    "Spiral Matrix": "https://leetcode.com/problems/spiral-matrix/description/",
    "Set Matrix Zeroes": "https://leetcode.com/problems/set-matrix-zeroes/description/",
    "Number of 1 Bits": "https://leetcode.com/problems/number-of-1-bits/description/",
    "Counting Bits": "https://leetcode.com/problems/counting-bits/description/",
    "Reverse Bits": "https://leetcode.com/problems/reverse-bits/description/",
    "Missing Number": "https://leetcode.com/problems/missing-number/description/",
    "Sum of Two Integers": "https://leetcode.com/problems/sum-of-two-integers/description/",
  };
}
