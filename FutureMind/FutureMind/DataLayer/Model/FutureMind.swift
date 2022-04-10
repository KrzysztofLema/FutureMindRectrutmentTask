//
//  futureMind.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 09/04/2022.
//

import Foundation

struct FutureMind: Hashable {
    let description: String
    let imageUrl: String
    let modificationDate: String
    let orderId: Int
    let title: String

   static let fakeData: [FutureMind] = [FutureMind(
            description:"Beef ribs boudin doner, rump capicola pork sirloin chuck shank porchetta.  Kielbasa short loin andouille biltong tongue tail chuck shankle.  Spare ribs tenderloin fatback pork loin rump ball tip.  Tongue ham hock pancetta shankle strip steak ribeye pig brisket capicola bacon rump spare ribs hamburger prosciutto chislic.  Shank salami ground round prosciutto pork belly pastrami porchetta frankfurter chicken biltong.  Jerky short ribs sirloin pastrami, ball tip tail pork loin ham salami.  Biltong chislic t-bone andouille.\n\nRump cow chislic, chicken tail pig corned beef pork tenderloin ribeye salami brisket pork chop boudin venison.  Andouille tri-tip pancetta pork belly ham hock sausage short loin ham fatback shank drumstick hamburger meatloaf.  Short loin porchetta venison shankle, alcatra ham boudin beef prosciutto capicola.  Fatback short ribs drumstick turducken, pastrami doner corned beef cow kevin.  Brisket porchetta shankle turducken drumstick ham sausage venison.  Ribeye spare ribs chislic pig.\thttp://sortmylist.com/",
            imageUrl: "https://i.picsum.photos/id/795/200/300.jpg?hmac=nVCcTtoBktz0APjPmi8v8r7YJ_Tw7u9vVX6gE1WTIxw",
            modificationDate: "2004-04-10",
            orderId: 4,
            title:"International rankings of the Dominican Republic"),
         FutureMind(
            description:"Turducken spare ribs swine salami prosciutto jerky t-bone picanha boudin.  Kielbasa hamburger turkey, brisket tri-tip porchetta chislic short loin turducken salami.  Tri-tip jerky ground round, pork filet mignon meatloaf doner spare ribs pork belly pastrami fatback sirloin.  Brisket ham meatball leberkas swine flank andouille chislic pork frankfurter tri-tip buffalo kielbasa doner.  Doner short loin kielbasa tenderloin ground round beef ribs ribeye tongue burgdoggen turducken.\n\nChislic short loin doner drumstick tail pork belly flank jowl.  Prosciutto landjaeger turducken ham hock.  Andouille pork shank pig, hamburger chuck prosciutto pancetta drumstick shoulder pork chop leberkas.  Boudin biltong corned beef strip steak shoulder chislic.  Biltong pig capicola boudin spare ribs sausage kevin filet mignon tongue ham pancetta.\thttps://www.khanacademy.org/",
            imageUrl:"https://i.picsum.photos/id/534/200/300.jpg?hmac=-mwH1XukRF8901AgoSI9MZSPdET9wCx3l43x0IkJSsU",
            modificationDate:"1979-08-16",
            orderId:3,
            title:"FIS Nordic World Ski Championships 2003") ]

}
