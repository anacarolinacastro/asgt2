//
//  main.m
//  anagrams
//
//  Created by Ana Carolina Castro on 8/31/14.
//  Copyright (c) 2014 full. All rights reserved.
//

#import <Foundation/Foundation.h>

bool isAnagram(NSString *word1, NSString *word2){
    if(word1.length == word2.length){
        word1 = [word1 lowercaseString];
        word2 = [word2 lowercaseString];
        
        NSMutableArray* lettersS1 = [NSMutableArray array];
        NSMutableArray* lettersS2 = [NSMutableArray array];
        
        if ([word1 length] != [word1 length]){
            return false;
        }
        
        for(int i = 0; i< [word1 length]; i++){
            NSRange myRange = NSMakeRange(i,1);
            [lettersS1 addObject:[word1 substringWithRange:myRange]];
            [lettersS2 addObject:[word2 substringWithRange:myRange]];
        }
        
        NSArray *sortedletterS1 = [lettersS1 sortedArrayUsingSelector:@selector(compare:)];
        NSArray *sortedletterS2 = [lettersS2 sortedArrayUsingSelector:@selector(compare:)];
        
        if([sortedletterS1 isEqualToArray:sortedletterS2]){
            return true;
        }else{
            return false;
        }
    }else{
        return 0;
    }
}

void anagrams()
{
    NSDate * beginTime = [NSDate date]; // gets the starting time
    FILE * wordsFile; // pointer to the file
    NSMutableArray * wordsArray = [NSMutableArray arrayWithObjects: nil]; // array to get the words
    
    // copy the words on file 'wordsFile' to 'wordsArray' array
    wordsFile = fopen("/Users/anacarolina/Documents/Fullerton/Mobile Dev Programming/anagrams/anagrams/words","r");
    if (wordsFile == NULL){
        NSLog(@"Error on opening file\n");
        exit(0);
    }else{
        char word[50];
        while (fscanf(wordsFile,"%s",word) != EOF){
            NSString * wordString = [NSString stringWithUTF8String:word];
            [wordsArray addObject:wordString];
        }
    }
    fclose(wordsFile);
    
    // order words by letters
    NSMutableArray * sortedWords = [NSMutableArray arrayWithObjects:nil];
    
    for (int j = 0; j<[wordsArray count]; j++) {
        
        NSString * wordSorted;
        NSMutableArray* letters = [NSMutableArray array];
        for(int i = 0; i<[wordsArray[j] length]; i++){
            NSRange myRange = NSMakeRange(i,1);
            [letters addObject:[[wordsArray[j] substringWithRange:myRange] lowercaseString]];
        }
        
        NSArray *sortedletter = [letters sortedArrayUsingSelector:@selector(compare:)];
        wordSorted = [sortedletter componentsJoinedByString:@""];
        //wordSorted = [wordSorted lowercaseString];
        [sortedWords addObject:wordSorted];
    }
    
    // order words alphabetically
    NSArray * sortedWords2 = [sortedWords sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSMutableArray * sortedWords3 = [(NSArray*)sortedWords2 mutableCopy];
    
    
    // find the word that most repeat
    NSString * word;
    
    int counter = 0;
    int counterAux = 0;
    int j =0;
    
    
    for (int i =0; i<[sortedWords3 count]-2; i++) {
        j = i+1;
        while ([[sortedWords3 objectAtIndex:i] isEqual: [sortedWords3 objectAtIndex:j]]){
            counterAux++;
            j++;
        }
        
        if (counterAux>counter) {
            counter = counterAux;
            word = [sortedWords3 objectAtIndex:i];
        }
        i = j-1;
        counterAux = 0;
    }
    
    
    // find the anagrams for the word
    NSMutableArray * anagrams = [NSMutableArray arrayWithObjects: nil];
    for (int i = 0; i<[wordsArray count]; i++) {
        if(isAnagram([wordsArray objectAtIndex:i], word)){
            [anagrams addObject:[wordsArray objectAtIndex:i]];
        }
    }
    
    NSLog(@"%@",anagrams);
    
    NSDate * endTime = [NSDate date]; // get the end time
    NSLog(@"Started at: %@", beginTime); // print the start time
    NSLog(@"Ended at: %@", endTime); // print the end time
    
}




int main(int argc, const char * argv[])
{
    @autoreleasepool {
        anagrams();
    }
    
    return 0;
}
