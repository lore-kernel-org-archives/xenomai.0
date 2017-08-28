References: <20170808112357.0063d74d@md1em3qc>
 <00264fd7-9cdd-afe0-0047-db7e0c2e8f40@numalliance.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3d887c58-950c-cd17-2b82-5f79304012c8@siemens.com>
Date: Mon, 28 Aug 2017 09:32:37 +0200
MIME-Version: 1.0
In-Reply-To: <00264fd7-9cdd-afe0-0047-db7e0c2e8f40@numalliance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [RFC] Xenomai3 tuneables replaced by environment
 variables
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>, Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 2017-08-28 08:25, Stéphane Ancelot wrote:
> Hi,
> 
> hardcoded and cmdline args benefits from an added value for real
> applications. We don't want args being "volatile"
> 
> environment variables are volatile and sometimes difficult to propagate
> between shells...

This is not about removing command line options completely. You can
still choose them if they fit your case better.

But given all the problems they cause to complex programs due to their
invasive nature, let's just make them them opt-in in 3.1 and switch to
conceptually cleaner env vars by default. For stable 3.0, we would keep
command line options as default, of course.

Jan

