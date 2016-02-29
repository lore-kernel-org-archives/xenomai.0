Date: Mon, 29 Feb 2016 21:24:11 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <56d4a8eb4617e0.42984600@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Subject: [Xenomai] RTnet -- receive broadcast frame at the local machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Dear Xenomai users,

Since RTnet has been integrated with Xenomai I address this question to you. The question is, how to receive a broadcast frame at the local machine without using the localhost? The issue is following, we have two process with separate rtsockets at the single machine (of course we have different machines in the network but this is not a case). One process send a broadcast UDP frame to the specified UDP port -- we have one rteth device on the machine. The second process listen on that port 
(receivefrom) and does not receive the broadcast frame sent by first process. I have found the following thread on the RTnet mailing list 

https://sourceforge.net/p/rtnet/mailman/message/6787561/

Could you please point me the place which should be hacked to duplicate outgoing packets if there are multiple
matching routes?

Best,
Mariusz



