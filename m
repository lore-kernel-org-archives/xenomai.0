Message-ID: <51A32CE7.8010309@control.lth.se>
Date: Mon, 27 May 2013 11:52:39 +0200
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
References: <1369479458.60083.YahooMailNeo@web172203.mail.ir2.yahoo.com>
	<51A0FE20.5040202@control.lth.se>
	<201305260224.59809.leo@alaxarxa.net>
	<20130526070035.3B231383193@gemini.denx.de>
In-Reply-To: <20130526070035.3B231383193@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai, rtnet and ethercat
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Denk <wd@denx.de>
Cc: Franz Engel <franz_lambert_engel@yahoo.de>, xenomai@xenomai.org

On 2013-05-26 09:00, Wolfgang Denk wrote:
> Dear Leopold Palomo Avellaneda,
>
> In message <201305260224.59809.leo@alaxarxa.net> you wrote:
>>
>> My recommendation is that if you don't want to make a commercial product, or
>> sell your software, you can use any of the two  ethercat master: soem and
>> etherlab. I don't think that Beckhoff makes you problems. If you want to do any
>> commercial product, ask to Beckoff first.
>
> The license terms make no such difference. As soon as you distribute
> any such system (no matter if commercial or otherwise, even for free)
> you are violating the terms.
>

It's even worse than that, you are not even allowed to use it internally 
without signing the EtherCAT license. At 2007 when ethercat.org was 
still stating that EtherCAT was GPL compatible/friendly, we wrote an 
EtherCAT master in realtime Java ([1], [2]). After having completed that 
when we were about to release it to the world, we were told by Beckhoff 
that in order to distribute or use it (even internal use!), we had to 
sign the Beckhoff license (hence that project was scrapped!). The GPL 
wording was also removed from the EtherCAT site at this time (the whole 
process of triyng to get the licensing right took almost two year, after 
this time we finally got an answer from Gerd Hoppe [3]).



Regards

Anders


[1] 
http://fileadmin.cs.lth.se/cs/Personal/Sven_Gestegard_Robertz/publ/jtres-flexpicker.pdf

[2] http://youtu.be/xH1yUXd9krU?t=3m47s

[3] Excerpt from email 2009-04-08:

"Therefore, any use of EtherCAT requires a license in addition to a 
copyright license for code such as L/GPL, regardless of any split of 
code in a licensed part and a L/GPL part."

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


