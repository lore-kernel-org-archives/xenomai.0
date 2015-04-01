MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Apr 2015 14:37:00 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <CE26B02160B73D4F82E70632544CC6823D2E3153@chnshlmbx11>
References: <20150317181631.GC16113@hermes.click-hack.org>
 <CE26B02160B73D4F82E70632544CC6823D2C3600@chnshlmbx11>
 <CE26B02160B73D4F82E70632544CC6823D2E30E1@chnshlmbx11>
 <0fae2988214e43a729ae9cd1442b2577@grandegger.com>
 <CE26B02160B73D4F82E70632544CC6823D2E3153@chnshlmbx11>
Message-ID: <e1815cb3d2d0bca0b984a82b02c2d339@grandegger.com>
Subject: Re: [Xenomai] CAN tx successfullness at Xenomai RT SocketCAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Narasimhaprasad Yedatore Achutha <Narasimhaprasad_A@infosys.com>
Cc: xenomai@xenomai.org

On Wed, 1 Apr 2015 12:04:16 +0000, Narasimhaprasad Yedatore Achutha
<Narasimhaprasad_A@infosys.com> wrote:
> Actually it will be definitely helpful if we can recognize through
> MSG_CONFIRM flag with CAN_RAW_RECV_OWN_MSGS options.
> Even with  loopback option  we can receive our own messages, but needs
> additional task time to separate it from external messages and its own
> transmitted messages as there will be mix of both,  additionally with
lot
> of backtracking. Here we just want to confirm whether the tx messages
has
> gone out successfully.

OK, I see.
 
> Incidentally socketcan also has a patch(refer net\can\raw.c   @
raw_rcv() )
> http://patchwork.ozlabs.org/patch/67893/
> 
> So a patch on this line,  will enable us to handle this in a better way.
> Please let me know the feasibility.

Yes, this approach is also feasible with RTCAN. Should not be a big deal
to implement it.

Wolfgang.


