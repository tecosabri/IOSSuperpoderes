//
//  TestingModels.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 17/10/22.
//

import Foundation

final class TestingModels {
    
    /// Gets four predefined characters for UI testing.
    static func getCharactersTesting() -> [CharacterViewModel] {
        
        let wolverine = Character(
            id: 1009718,
            name: "Wolverine",
            description: "Born with super-human senses and the power to heal from almost any wound, Wolverine was captured by a secret Canadian organization and given an unbreakable skeleton and claws. Treated like an animal, it took years for him to control himself. Now, he's a premiere member of both the X-Men and the Avengers.",
            modified: "2016-05-02T12:21:44-0400",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/2/60/537bcaef0f6cf.jpg"),
            series: SeriesContainer(
                available: 2,
                collectionURI: "http://gateway.marvel.com/v1/public/characters/1009718/series",
                items: [
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/12429",
                        name: "5 Ronin (2010)"),
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/18142",
                        name: "Amazing X-Men (2013 - 2015)")],
                returned: 2))
        
        let captainAmerica = Character(
            id: 1009220,
            name: "Captain America",
            description: "Vowing to serve his country any way he could, young Steve Rogers took the super soldier serum to become America's one-man army. Fighting for the red, white and blue for over 60 years, Captain America is the living, breathing symbol of freedom and liberty.",
            modified: "2020-04-04T19:01:59-0400",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087.jpg"),
            series: SeriesContainer(
                available: 2,
                collectionURI: "http://gateway.marvel.com/v1/public/characters/1009220/series",
                items: [
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/16450",
                        name: "A+X (2012 - 2014)"),
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/3620",
                        name: "A-Next (1998 - 1999)")],
                returned: 2))
        
        let blackWidow = Character(
            id: 1009189,
            name: "Black Widow",
            description: "Like her namesake arachnid, Romanoff is stealthy, precise, and absolutely lethal. She is the Black Widow. Black Widow is a deadly one-woman fighting force. An expert in many forms of martial arts, she is also a skilled gymnast and possesses superhuman strength, speed, agility, and endurance.",
            modified: "2016-01-04T18:09:26-0500",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/f/30/50fecad1f395b.jpg"),
            series: SeriesContainer(
                available: 2,
                collectionURI: "http://gateway.marvel.com/v1/public/characters/1009189/series",
                items: [
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/16450",
                        name: "A+X (2012 - 2014)"),
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/6079",
                        name: "Adam: Legend of the Blue Marvel (2008)")],
                returned: 2))
        
        let thor = Character(
            id: 1009664,
            name: "Thor",
            description: "As the Norse God of thunder and lightning, Thor wields one of the greatest weapons ever made, the enchanted hammer Mjolnir. While others have described Thor as an over-muscled, oafish imbecile, he's quite smart and compassionate.  He's self-assured, and he would never, ever stop fighting for a worthwhile cause.",
            modified: "2020-03-11T10:18:57-0400",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/d/d0/5269657a74350.jpg"),
            series: SeriesContainer(
                available: 2,
                collectionURI: "http://gateway.marvel.com/v1/public/characters/1009664/series",
                items: [
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/16450",
                        name: "A+X (2012 - 2014)"),
                    SeriesItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/series/9790",
                        name: "Age of Heroes (2010)")],
                returned: 2))
        
        return [CharacterViewModel(fromCharacter: wolverine),
                CharacterViewModel(fromCharacter: captainAmerica),
                CharacterViewModel(fromCharacter: blackWidow),
                CharacterViewModel(fromCharacter: thor)]
    }
    
    /// Gets three predefined series and assigns them to the `series`property.
    static func getSeriesTesting() -> [Serie] {
        
        let aPlusX = Serie(
            id: 16450,
            title: "A+X (2012 - 2014)",
            description: "Get ready for action-packed stories featuring team-ups from your favorite Marvel heroes every month! First, a story where Wolverine and Hulk come together, and then Captain America and Cable meet up! But will each partner's combined strength be enough?",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34"))
        
        let newXMen = Serie(
            id: 16449,
            title: "All-New X-Men (2012 - 2015)",
            description: "In the wake of the events of Avengers Vs. X-Men, the mutant world is set to receive a big blast from the past, in the form of the original X-Men! How will the young, unsuspecting mutants from the past - including Jean Grey - react to the conflict and turmoil that has engulfed the world of their future?",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/60/5384e7d05aaee"))
        
        let newWolverine = Serie(
            id: 22728,
            title: "All-New Wolverine Vol. 5: Orphans of X (2018)",
            description: "Daken has been kidnapped, and it's up to Wolverine to find him. But when his trail brings her back to the Facility, the place that tortured and created her, what new horrors will Laura find cooking there? Who, exactly, are the Orphans of X? How are they connected to the Wolverine? And what do they know about Laura and her past?",
            thumbnail: Thumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/3/b0/5a84b58724b37/clean.jpg"))
        
        
        let wolverineSeries = [aPlusX, newXMen, newWolverine]
        
        return wolverineSeries
    }
}
