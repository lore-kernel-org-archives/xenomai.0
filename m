Date: Mon, 14 Dec 2015 23:45:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151214224518.GF16627@hermes.click-hack.org>
References: <f032b1abe1d947cab8a89e20759c07a0@CHNSHLMBX32.ad.infosys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f032b1abe1d947cab8a89e20759c07a0@CHNSHLMBX32.ad.infosys.com>
Subject: Re: [Xenomai] CAN Loopback with Recieve own message
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Narasimhaprasad Yedatore Achutha <Narasimhaprasad_A@infosys.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Sat, Dec 12, 2015 at 01:42:01PM +0000, Narasimhaprasad Yedatore Achutha wrote:
> Hello All
> 
> I have a question on RT-Socket not supporting Receive own message
> option(CAN_RAW_RECV_OWN_MSGS ) with MSG_CONFIRM flag not
> supported. I'm trying to understand, if we modify the kernel
> driver supporting CAN_RAW_RECV_OWN_MSGS, so that we start
> receiving transmitted message back at the controller, how much an
> impact happens on
> 
> -          Real time scheduling
> 
> -          Does CAN message missing cases be frequent at high bus
> -          load for real time applications
> 
> -          Any other impact we need to consider?
> 
> Please let me know if anybody has any experience on this or any
> experiments to share?. Any thoughts or advice will be helpful

I do not see any other reason for not having CAN_RAW_RECV_OWN_MSGS
than the fact that nobody needed this, so nobody implemented it.

-- 
					    Gilles.
https://click-hack.org

