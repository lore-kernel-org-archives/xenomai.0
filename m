Message-ID: <4DCC44B8.80906@domain.hid>
Date: Thu, 12 May 2011 22:36:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <184545.11821.qm@domain.hid>
In-Reply-To: <184545.11821.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IDDP/XDDP File/Socket descriptors with
	select/epoll
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guvenc Gulce <gulceg@domain.hid>
Cc: Xenomai-help@domain.hid

On 05/12/2011 08:02 PM, Guvenc Gulce wrote:
> Hi
> The Xenomai IPC Mechanisms IDDP and XDDP use the Posix Socket API.
> Is it possible to monitor the returned file/socket descriptors of IDDP/XDDP
> sockets using the select/epoll mechanisms ?
> 
> For example can we monitor the socket descriptors of IDDP Sockets using
> the posix select and/or linux epoll mechanism if those sockets
> are running in the context of two xenomai real time threads which are 
> trying to communicate with each other over IDDP ?

The posix skin has a select service, which requires support from the
underlying driver, which nobody has implemented for the IDDP/XDDP
sockets. But we would welcome patches doing so.

-- 
                                                                Gilles.

