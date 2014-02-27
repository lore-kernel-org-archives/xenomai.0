Message-ID: <530F08DC.3040902@sigmatek.at>
Date: Thu, 27 Feb 2014 10:43:56 +0100
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] priority inheritance question
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

have 2 tasks
task1 with prio 10
task2 with prio 20

task1 acquire a mutex
now task2 will acquire the same mutex

than task1 get higher priority.

But what gets priority task1?
20 or 21 ?

Thanks
   Johann

