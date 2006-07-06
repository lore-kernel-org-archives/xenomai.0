From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17580.62726.293737.991643@domain.hid>
Date: Thu, 6 Jul 2006 13:33:26 +0200
Subject: Re: [Xenomai-help] FPU not available in user-space programs
In-Reply-To: <44AC8482.6000902@domain.hid>
References: <44AC8482.6000902@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

Rodrigo Rosenfeld Rosas wrote:
 > Hi,
 > 
 > I was looking at /proc/xenomai/faults and noticed that the only errors 
 > were on TRAP 7 (FPU not available).
 > 
 > Each time I run the user-space program using the native skin, I 
 > increment the fault by one. I don't understand why this happens. From 
 > documentation, FPU should be enabled automatically for user-space programs.
 > 
 > Any ideas why I'm getting this error and what does it mean? Should I do 
 > some float-point operation before creating my real-time tasks?

This fault is not an error, it happens when a task use the FPU for the
first time in primary mode. When in secondary mode, such an FPU fault
happens every time the FPU is used after a context switch, you simply do
not know about it because it is not accounted for.

-- 


					    Gilles Chanteperdrix.

