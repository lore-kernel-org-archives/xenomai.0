Subject: Re: smokey arm64 gdb tests
References: <4d2b41d6-2b78-5d49-6ddb-94741eab6e3a@siemens.com>
 <c64bcbab-bb0f-5949-466a-5754b125be0f@siemens.com>
 <10554621.zqTsMMC2SS@omoikane>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8edd3192-301c-3f27-4889-21b6a3d91cd1@siemens.com>
Date: Thu, 3 Oct 2019 10:23:00 +0200
MIME-Version: 1.0
In-Reply-To: <10554621.zqTsMMC2SS@omoikane>
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
To: "steven.seeger flightsystems.net" <steven.seeger@flightsystems.net>
Cc: Gylstorff Quirin <quirin.gylstorff@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 02.10.19 14:36, steven.seeger flightsystems.net wrote:
> On Wednesday, October 2, 2019 5:38:09 AM EDT Jan Kiszka wrote:
>> Still, I suspect we need to deal with missing support, also because ppc
>> shouldn't have that yet, Steven, am I right? It's "just" a debugging
>> feature, nothing otherwise problematic or relevant for applications. So I'm
>> unsure if that deserves an ABI flag, but that would be needed to detect the
>> issue smoothly in the testsuite.
> 
> I'm not sure what this is. Do you mean the WARNSW option? PPC supports that.
> 

Nope,

https://gitlab.denx.de/Xenomai/ipipe-arm/commit/5720abf5df213d0eb392bc4f5620f5f4bf5f3a23

or

https://gitlab.denx.de/Xenomai/ipipe-x86/commit/69e53186060197af91b2056b0da0c3032d7ec0d8

to make use of

https://gitlab.denx.de/Xenomai/ipipe-x86/commit/c5b7844523ef572e4096262df2e2cd503b84e539

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

