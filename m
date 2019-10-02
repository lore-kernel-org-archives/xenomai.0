Subject: Re: smokey arm64 gdb tests
References: <4d2b41d6-2b78-5d49-6ddb-94741eab6e3a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c64bcbab-bb0f-5949-466a-5754b125be0f@siemens.com>
Date: Wed, 2 Oct 2019 11:38:09 +0200
MIME-Version: 1.0
In-Reply-To: <4d2b41d6-2b78-5d49-6ddb-94741eab6e3a@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, Steven Seeger <steven.seeger@flightsystems.net>

On 02.10.19 10:37, Gylstorff Quirin wrote:
> Hi,
> 
> I did a run of smokey on arm64 and it aborts in the gdb test with the error:
> FAILURE run_gdb:287: checking expression \"primary_mode\", expected \"1\", found 
> \"0\"
> 
> 
> My question should the gdb test run on arm64?
> If not we should exclude it for the time being.

Damn, that's the still missing userspace return notifier support on arm64. I 
will try to look into this.

Still, I suspect we need to deal with missing support, also because ppc 
shouldn't have that yet, Steven, am I right? It's "just" a debugging feature, 
nothing otherwise problematic or relevant for applications. So I'm unsure if 
that deserves an ABI flag, but that would be needed to detect the issue smoothly 
in the testsuite.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

