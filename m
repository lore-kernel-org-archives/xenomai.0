Date: Fri, 29 Apr 2016 22:06:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160429200628.GS1881@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A731FEF@mb2010-3.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A731FEF@mb2010-3.intra.tut.fi>
Subject: Re: [Xenomai] rtdm_socket() error -97 for sending UDP or RAW packets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Apr 29, 2016 at 01:45:53PM +0000, Umair Ali wrote:
> Hello there,
> 
> I am working to make a module which will uses the Rtnet module to
> send the UDP or RAW pakets. My aim is to use the interface
> 'rteth0' in kernel space same like in userspace. Therefore I think
> I should create the socket and then using the created socket link
> the interface rteth0 with it. But when I use the function
> 'rtdm_socket(PF_INET, SOCK_RAW,0)' or 'rtdm_socket(PF_PACKET,
> SOCK_RAW,0)' or 'rtdm_socket(PF_INET, SOCK_DGRAM,0)' or anything
> with available options i.e also with sock_stream. I got the error
> -97. Which I have looked in google means the family of protocol is
> not supported. Please tell me if it is possible to send the UDP
> packets from the kernel space using interface rteth0 and socket or
> not. Can u guide me how I can solve the error -97. Thanks in
> advance

Sorry, no, I never used RTnet interface in kernel-space. I seem to
recall not all functions may be called from all contexts (for
instance, calling socket may work from the init module, but not from
a real-time thread or vice versa), but apart from that, I have no
clue. The best answer at this point would be "use the source, Luke".

Regards.

-- 
					    Gilles.
https://click-hack.org

