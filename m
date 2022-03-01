Message-ID: <93b4b26c-3a1c-a15a-97f4-f35fd5630172@siemens.com>
Date: Tue, 1 Mar 2022 21:22:45 +0100
MIME-Version: 1.0
Subject: Re: [I-pipe][PATCH v2 0/4] ipipe: x86: Fix IRQ migrations, avoid
 confusing kernel messages
Content-Language: en-US
References: <20220301125302.2368068-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220301125302.2368068-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 01.03.22 13:52, Florian Bezdeka wrote:
> Hi,
> 
> this are the results from an internal debugging session. We we're facing 
> some problems related to system tunings and some confusing kernel
> messages related to spurious IRQs.
> 
> The most important part:
> IRQ migrations were broken in 4.19 and 5.4 based branches 
> 
> Patch 1 is compile tested only.
> 
> Changes to v1:
>   - Add Patch 1, "Backport" for ipipe 4.4 branch
>   - Add Patch 3, Fix IRQ migrations for 5.4
>   - Add Patch 4, Fix IRQ migrations for 4.19
> 
> Best regards,
> Florian
> 
> Florian Bezdeka (3):
>   [4.4]       ipipe: x86: Do not call BUG() in case of retriggered APIC 
>               vectors
>   [4.19, 5.4] ipipe: x86: Suppress unexpected trap warning for racing APIC 
>               vectors
>   [5.4]       ipipe: x86: Fix IRQ migrations, pending migrations were
>               never handled
>   [4.19]      ipipe: x86: Fix IRQ migrations, pending migrations were
>               never handled

Thanks for these non-trivial fixes! All applied now, CI running.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

