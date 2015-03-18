Date: Wed, 18 Mar 2015 09:42:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150318084250.GO16113@hermes.click-hack.org>
References: <20150317181631.GC16113@hermes.click-hack.org>
 <CE26B02160B73D4F82E70632544CC6823D2C3600@chnshlmbx11>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE26B02160B73D4F82E70632544CC6823D2C3600@chnshlmbx11>
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
Cc: "'xenomai-owner@xenomai.org'" <xenomai-owner@xenomai.org>, "'xenomai@xenomai.org'" <xenomai@xenomai.org>

On Wed, Mar 18, 2015 at 08:27:06AM +0000, Narasimhaprasad Yedatore Achutha wrote:
> Hello All
> I'm using RTSocket CAN in my application. Trying figure out how to ensure the CAN message tranmission succesfulness in my function
> Previuosly I was able to assess the echoed (recv own msg) message with MSG_CONFIRM flag returned by recvmsg() while using just socket CAN functionalities.
> However with RT SOcket CAN, the CAN_RAW_RECV_OWN_MSGS is not supported at rt_dev_setsockopt, and because of this the MSG_CONFIRM isnot being set at msg flags in the received messages.
> Could please elaborate how do we make sure the tx message successfulness are assesed at RT socket CAN.
> Thanks

Apparently you did not get it the first time, so I am going to try
again:

PLEASE DO NOT SEND MAILING LIST QUESTIONS TO THE XENOMAI-OWNER ADDRESS.

-- 
					    Gilles.

