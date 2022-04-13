Message-ID: <1e9b7d24-a1db-7849-568d-36756584570a@siemens.com>
Date: Wed, 13 Apr 2022 14:56:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] Revive alchemy tests
Content-Language: en-US
References: <20220408080401.22235-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220408080401.22235-1-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org

On 08.04.22 10:03, Richard Weinberger via Xenomai wrote:
> This patch series is a first attempt to integrate the currently abandoned
> alchemy tests into Xenomai's test suite.
> Since each test assumes running as own process a test driver is needed
> which executes each tests separately.
> The driver makes use of the smokey framework.
> 

A valuable step forward. Just wondering, before actually taking it, if
that can be a pattern for the rest as well (psos, vxworks) or if there
is anything that should be considered in addition to allow them
following later on.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

