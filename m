From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17461.4788.260545.832005@domain.hid>
Date: Thu, 6 Apr 2006 15:08:04 +0200
Subject: Re: [Xenomai-help] Doxygen fails to document rt_task_send() and
	friends
In-Reply-To: <44344E6C.3070305@domain.hid>
References: <44344E6C.3070305@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vincent Levesque <vleves@domain.hid>
Cc: xenomai@xenomai.org

Vincent Levesque wrote:
 > Hi,
 > 
 > I just noticed that doxygen doesn't seem to document rt_task_send(), 
 > rt_task_receive() and rt_task_reply() anymore (e.g. 
 > http://www.xenomai.org/documentation/branches/v2.1.x/html/api/group__task.html).
 > 
 > The problem seems to be due to a "#ifdef CONFIG_XENO_OPT_NATIVE_MPS" 
 > command in "/ksrc/skins/native/task.c". Sorry, no patch for now...

The patch is to add CONFIG_XENO_OPT_NATIVE_MPS to the value of Doxyfile
PREDEFINED tag. The documentation in the repository is up to date.

-- 


					    Gilles Chanteperdrix.

