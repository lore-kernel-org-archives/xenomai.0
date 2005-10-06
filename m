Message-ID: <4344C9B8.5010304@domain.hid>
Date: Thu, 06 Oct 2005 09:52:40 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] PPC64 Adeos patch r2
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: rtai-dev@domain.hid, Philippe Gerum <rpm@xenomai.org>

Updated PPC64 adeos patch (r2) available at:

http://www.cs.helsinki.fi/group/nonsto/adeos-linux-2.6.10-ppc64-r2.patch.gz

Protected some mm sections with the downside of somewhat increased 
latency. Much more stable when there's background Linux activity.

-- Heikki Lindholm


