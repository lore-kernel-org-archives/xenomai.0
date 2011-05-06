Message-ID: <4DC3C04A.90801@domain.hid>
Date: Fri, 06 May 2011 15:32:58 +0600
From: Alexey Galakhov <agalakhov@domain.hid>
MIME-Version: 1.0
References: <4DC2962B.9060802@domain.hid> <4DC299F2.40700@domain.hid>
	<4DC2A315.8030707@domain.hid> <4DC2ADE1.9000301@domain.hid>
	<4DC2B06B.9020303@domain.hid> <4DC2B75C.8030503@domain.hid>
	<4DC2C10C.9080102@domain.hid> <4DC2C411.60109@domain.hid>
	<4DC2D0C9.3020605@domain.hid> <4DC2DDC6.8090909@domain.hid>
In-Reply-To: <4DC2DDC6.8090909@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] mini2440: ipipe kernel stuck in idle loop after
 xenomai init
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

On 05/05/2011 11:26 PM, Gilles Chanteperdrix wrote:
> Please try and move the cal to ipipe_tsc_update to the acktimer function.
> Also call printk in the actkimer function, in order to see if the last
> action is a set_dec, or an acktimer.
Tried to move the call. Got exactly the same hangup and dmesg.

--
Alex

