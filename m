References: <CAMcKmiG4M5gW_bcYLM0Zg57k2ySSbs5skkf32EFchwYkUNvMDQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <11791336-01d4-3921-ed8f-12308103c9f6@xenomai.org>
Date: Wed, 12 Apr 2017 11:03:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAMcKmiG4M5gW_bcYLM0Zg57k2ySSbs5skkf32EFchwYkUNvMDQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 0-priority task in Cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Broz <brozgeo@gmail.com>, xenomai@xenomai.org

On 04/12/2017 01:44 AM, George Broz wrote:
> Hello,
> 
> In the native skin for Xenomai 2.6.x, it was possible to create a
> 0-priority task - a Xenomai task that spends its life in secondary
> mode except when calling/interacting with Xenomai services that would
> temporarily promote it to primary mode.
> 
> Is it possible to create a 0-priority task through the Cobalt skin?
> What are the calls/arguments needed?
> 
> 

The equivalent is creating a thread using pthread_create() with the
SCHED_OTHER policy (which requires priority 0 in the sched_param
settings). libcobalt's pthread_setschedparam() can be used for the same
purpose on an existing thread.

-- 
Philippe.

