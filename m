Subject: Re: CPU affinity and scheduler
References: <CAFZ-hKgU4jY1BVU+zL8VFJ1icouqzU-KUJmUs+_rLcX_5Wd_Pg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ea162f0f-3fec-207d-f91d-1d4d0e41ec65@siemens.com>
Date: Thu, 7 Jan 2021 13:22:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAFZ-hKgU4jY1BVU+zL8VFJ1icouqzU-KUJmUs+_rLcX_5Wd_Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leandro Bucci <guestleandro11@gmail.com>, xenomai@xenomai.org

On 02.01.21 11:38, Leandro Bucci via Xenomai wrote:
> Hello and happy new year to all. I wanted to ask you in detail what this
> line means:
> 
> isolcpus=0,1 xenomai.supported_cpus=0x3
> 
> I understand that 2 CPUs are isolated. (I'm working on a Raspberry). But in
> what sense are they isolated? does it mean that if a xenomai Task runs on
> one of the two CPUs it will never migrate to another CPU? instead what does
> "xenomai supported CPU" mean? that only that CPU supports Xenomai? but then
> why is CPU 3 not isolated?
> 

isolcpus specifies the isolation for Linux tasks: Nothing is put on this
CPUs by Linux unless explicitly requested (eg. via taskset or thread
affinities) or strictly required (a few kernel threads). That helps to
keep those core free for RT jobs.

supported_cpus then tells Xenomai to only schedule on those cores and do
not intercept Linux (except where technically needed) on the others.
That parameter is specified as mask, thus core ID 0 and 1 are selected here.

All that does not protect you from hardware related interference,
though. Caches might be shared between the core groups, just like I/O paths.

HTH,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

