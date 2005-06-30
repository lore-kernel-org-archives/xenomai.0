Message-ID: <42C42FD4.9050307@domain.hid>
Date: Thu, 30 Jun 2005 20:45:56 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] ANNOUNCE: Adeos and Fusion PPC64 port updated
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: rtai-dev@domain.hid
Cc: adeos-main@gna.org

Hello list,

We've updated the adeos+fusion ppc64 ports. Updated versions available at

http://www.cs.helsinki.fi/group/nonsto/rtaippc64.html

It's starting to get usable. Changes as follows,
Adeos (r2c1):
* timer support added
* fixed syscall bug
* integrated changes from 2.6.10-ppc-r7 patch
* disabled threaded domains for now
Fusion (r2):
* bumped to 0.8.1 fusion
* fixed kernel thread switching

p.s. regardless of the (unfortunate) r6c1 versioning of the former 
version, it's older

-- Heikki Lindholm



