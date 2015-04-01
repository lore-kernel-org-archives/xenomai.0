MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Apr 2015 13:06:36 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <CE26B02160B73D4F82E70632544CC6823D2E30E1@chnshlmbx11>
References: <20150317181631.GC16113@hermes.click-hack.org>
 <CE26B02160B73D4F82E70632544CC6823D2C3600@chnshlmbx11>
 <CE26B02160B73D4F82E70632544CC6823D2E30E1@chnshlmbx11>
Message-ID: <0fae2988214e43a729ae9cd1442b2577@grandegger.com>
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

On Wed, 1 Apr 2015 10:19:31 +0000, Narasimhaprasad Yedatore Achutha
<Narasimhaprasad_A@infosys.com> wrote:
> Hi All
> Could anybody share details on this query?

See below.

> 
> Thanks and Regards
> Prasad
> 
> -----Original Message-----
> From: Narasimhaprasad Yedatore Achutha 
> Sent: Wednesday, March 18, 2015 1:57 PM
> To: 'gilles.chanteperdrix@xenomai.org'; 'xenomai-owner@xenomai.org';
> 'xenomai@xenomai.org'
> Subject: Re: CAN tx successfullness at Xenomai RT SocketCAN
> 
> Hello All
> I'm using RTSocket CAN in my application. Trying figure out how to
ensure
> the CAN message tranmission succesfulness in my function Previuosly I
was
> able to assess the echoed (recv own msg) message with MSG_CONFIRM flag
> returned by recvmsg() while using just socket CAN functionalities.
> However with RT SOcket CAN, the CAN_RAW_RECV_OWN_MSGS is not supported
at
> rt_dev_setsockopt, and because of this the MSG_CONFIRM isnot being set
at
> msg flags in the received messages.
> Could please elaborate how do we make sure the tx message successfulness
> are assesed at RT socket CAN.

As a workaround you could open another socket to receive the looped back
message. Also implementing CAN_RAW_RECV_OWN_MSGS should not be a big deal.
The delivery skipping the own socket is done here:

http://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/can/rtcan_raw.c#n194

Wolfgang.


