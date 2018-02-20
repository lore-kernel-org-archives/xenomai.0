References: <cover.1518786423.git.henning.schild@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6f431818-1eec-a3eb-5a95-44f7dc5f2d79@xenomai.org>
Date: Tue, 20 Feb 2018 10:27:05 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1518786423.git.henning.schild@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 0/5] dlopen()/dlclose() bugfix with testcase
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 02/16/2018 02:13 PM, Henning Schild wrote:
> In order to fix a segfault in a dlopen()/dlclose()/dlopen() sequence i
> wrote a testcase to reproduce the issue. That testcase also covers a few
> other dlopen-related things.
> The testcase is intetgrated into smokey. Because a smokey-test is already
> a xenomai-application the actual test-program gets launched from the
> testcase. And that program is a non-xenomai application which gains
> xenomai-functionality with dlopen().
> The series also contains preparation and fixes along the way
> (posix-fork).
> 
> Henning Schild (5):
>   smokey/posix-fork: fix binary path for configure --with-testdir
>   smokey/posix-fork: actually wait for the process to exit
>   smokey/posix-fork: move fork/exec functionality into libsmokey
>   smokey/dlopen: introduce a new testcase
>   boilerplate/setup: introduce destructors for __setup_call
> 
>  configure.ac                              |  2 +
>  include/boilerplate/setup.h               |  7 +++
>  include/smokey/smokey.h                   |  8 +++
>  lib/boilerplate/setup.c                   |  6 +++
>  lib/smokey/helpers.c                      | 31 +++++++++++
>  testsuite/smokey/Makefile.am              |  4 ++
>  testsuite/smokey/dlopen/Makefile.am       | 63 ++++++++++++++++++++++
>  testsuite/smokey/dlopen/dlopen.c          | 44 ++++++++++++++++
>  testsuite/smokey/dlopen/dlopentest.c      | 88 +++++++++++++++++++++++++++++++
>  testsuite/smokey/dlopen/libalchemy-test.c | 65 +++++++++++++++++++++++
>  testsuite/smokey/dlopen/libposix-test.c   | 32 +++++++++++
>  testsuite/smokey/posix-fork/Makefile.am   |  5 +-
>  testsuite/smokey/posix-fork/posix-fork.c  | 33 ++----------
>  13 files changed, 358 insertions(+), 30 deletions(-)
>  create mode 100644 testsuite/smokey/dlopen/Makefile.am
>  create mode 100644 testsuite/smokey/dlopen/dlopen.c
>  create mode 100644 testsuite/smokey/dlopen/dlopentest.c
>  create mode 100644 testsuite/smokey/dlopen/libalchemy-test.c
>  create mode 100644 testsuite/smokey/dlopen/libposix-test.c
> 

Merged, thanks.

-- 
Philippe.

