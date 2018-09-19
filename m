Message-ID: <653076205.1537344140916.JavaMail.root@webmail>
Date: Wed, 19 Sep 2018 17:02:20 +0900 (KST)
From: =?EUC-KR?B?udrA58ij?= <jaeho@seoultech.ac.kr>
Reply-To: =?EUC-KR?B?udrA58ij?= <jaeho@seoultech.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] kernelshark to check the CPU usage of the xenomai task.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi, all



I'm using kernelshark to check the CPU usage of the xenomai task.



To check the cpu share of the xenomai task according to the cpu load given by Linux.

Using the stress-ng tool on Linux .

"# stress-ng -c0 -l100" 

gives 100% load to cpu, and xenomai has a run time of 750us for 1ms cycle.



Checking /proc/xenomai/stat we were able to verify the use of 75% CPU. 

However, I checked the cpu quota of xenomai and linux(stress-ng) using tracd-cmd and kernelshark 

I expected xenomai to use more cpu because its priority was higher than normal Linux, but the result was not so. 

The task that is "ecat-embedded" in the picture is the xenomai task. Why are these results coming out?



thank you for your advice.

