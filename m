References: <B89CCBE86D4F62448EE4F6367C6D3C89221E32ED@USMLVA0EM24MSX.ww017.siemens.net>
 <560AB34B.5020300@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4342@USMLVA0EM24MSX.ww017.siemens.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <560AB938.8090905@xenomai.org>
Date: Tue, 29 Sep 2015 18:15:52 +0200
MIME-Version: 1.0
In-Reply-To: <B89CCBE86D4F62448EE4F6367C6D3C89221E4342@USMLVA0EM24MSX.ww017.siemens.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai
	2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/29/2015 06:04 PM, PRADHAN, MAKARAND (RC-CA) wrote:
>> Are you playing with the T_LOCK bit?
> 
> Yes. We do T_LOCK to lock the scheduler while we are in a critical section. Is that why the scheduler does not kick in immediately after the HW int?

If the IRQ happens while some task holds the scheduler lock, the answer
is yes, that is the point of it.

The scheduler lock is an ugly construct inherited from the dark ages of
RTOS. Xenomai being about properly emulating these for running legacy
code is the only reason why this anti-feature is present. I would
strongly recommend to use a mutual exclusion mechanism with a finer
granularity.

-- 
Philippe.

