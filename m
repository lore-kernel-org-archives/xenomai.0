Subject: Re: running xenomai through scan-build or: some 100 issues with
 static code analysis
References: <CADYdroOdDNumXRbjFu20UpJkHH8S7W0xMHRzRpiWpk+_0PZHJw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fd1615a6-2dbd-2b4a-a057-80cab4f8e245@siemens.com>
Date: Mon, 14 Oct 2019 08:25:48 +0200
MIME-Version: 1.0
In-Reply-To: <CADYdroOdDNumXRbjFu20UpJkHH8S7W0xMHRzRpiWpk+_0PZHJw@mail.gmail.com>
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
To: Norbert Lange <nolange79@gmail.com>, Xenomai <xenomai@xenomai.org>

On 13.10.19 21:49, Norbert Lange via Xenomai wrote:
> Hello,
> 
> I did run some static analysis tools over xenomai 3.1rc2 userspace libraries,
> and there seems to be alot of real issues.
> 
> The tools are clangs builtin statical analysis and clang-tidy, naturally there
> is some overlap in the reports.
> clang-tidy would need to be configured to fit Xenomai's practices
> (there is a ton of configurable checks), so this is more of an example.
> The other, clang's statical analysis is more relevant as there are very few
> false positives.
> 
> Additionally to the checks, there is a directory failures, files that cant
> be built with clang. Even if no one ships Xenomai built by that compiler,
> fixing those should help, for being able to run those tools and several IDE's
> and Editors already use clangd for code competition etc.
> 
> I'd hope that such reports could be incorporated into the CI builds.
> running the analysis on cross-builds is alot more daunting,
> but on native builds its rather easy.

This is generally a valuable thing. Unfortunately, it starts with some
more work: modelling of functions and syscalls that clang has no insight
into and, thus, throws false-positives around them. Quickly browsing
through the report, I only saw one real finding so far, and that was a
harmless "assigned but never used" warning. But I'm sure that there are
a few more severe issues in that haystack.

I was already considering to enable Coverity via our CI. It generally
works, it has proven to find real issues without too much modelling
effort (though this case may be different because of all the custom
syscalls), but since Synopsis bought it, the availability and quality of
their public OSS service massively degraded.

So, looking into clang might be a more reliable alternative. I'm open
for patches that pave the way. For CI, we may need a more recent source
than clang-6 because that is what Travis provides us ATM.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

