From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4E384CFE.6060900@domain.hid>
References: <1312230016-21196-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<4E384CFE.6060900@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Aug 2011 21:58:53 +0200
Message-ID: <1312315133.2099.42.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] heap: rename sys_sem_heap syscall to
 sys_heap_info
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, 2011-08-02 at 21:16 +0200, Gilles Chanteperdrix wrote:
> On 08/01/2011 10:20 PM, Gilles Chanteperdrix wrote:
> > And add the count of used bytes to the xnheap_desc structure. This allows
> > for checking for leaks in unit tests.
> > ---
> 
> No comments?

Fine with me.

-- 
Philippe.



