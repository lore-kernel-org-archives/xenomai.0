MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18454.19282.131873.459681@domain.hid>
Date: Tue, 29 Apr 2008 00:10:26 +0200
In-Reply-To: <116810.74312.qm@domain.hid>
References: <116810.74312.qm@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] rtdm's communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: egemen kaleli <menege1@domain.hid>
Cc: xenomai@xenomai.org

egemen kaleli wrote:
 > Hello,
 >    
 >   I have developed  a driver with rtdm and it woks well.I know that rtdm uses 4MB shared memory at maximum capacity.To progress for further work I need to learn whether rtdm kernel and user space functions uses shared memory or pipe.If pipe it will ease my work.thanks for all help in advance.

The communication between rtdm kernel-space and user-space is done
through real-time system calls. If it was based on pipes, it would mean
that only task without real-time characteristics could access real-time
drivers. We would then loose any interest in real-time drivers.

-- 


					    Gilles.

