References: <20111223173309.GM27742@domain.hid> <4F045578.7090405@domain.hid>
From: Frank Benkert <xenomai@frank-benkert.de>
Message-ID: <414a96f6-a471-c0d0-4199-f7eacf6ef1da@frank-benkert.de>
Date: Wed, 21 Mar 2018 16:40:23 +0100
MIME-Version: 1.0
In-Reply-To: <4F045578.7090405@domain.hid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [Xenomai-core] CONFIG_XENO_HW_UNLOCKED_SWITCH=y causes
 random process corruption in xenomai 2.6.0 on powerpc.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Sorry for pumping this old topic, but it needs some clarification:

For all of you who find this thread via search engines because you are 
looking for sporadic crashes on Xenomai PowerPC in relation to task 
switches:
This patch does not fix the problem - at least not in our case. After 
several years, the problem suddenly appeared with us, as we are now 
increasingly using the Ethernet interface on our old product. Maybe the 
new interrupt load triggers this old bug.

There is a patch in Xenomai 3 which removes the buggy feature because of 
problems with the MMU.
The only way to fix these sporadic crashes is to disable the switch 
(CONFIG_XENO_HW_UNLOCKED_SWITCH=n).

See also
http://git.xenomai.org/?p=ipipe.git;a=commit;h=614aa59453dacf7693fbb18229c27676c2803dbb
http://git.xenomai.org/?p=ipipe.git;a=commit;h=04ea520ab96a16ec65529a2efed92c9a4a8bda34


