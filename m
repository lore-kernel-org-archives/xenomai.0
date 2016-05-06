References: <E1aybuF-00044d-BO@sd-51317.xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <572C6719.5070900@xenomai.org>
Date: Fri, 6 May 2016 11:42:49 +0200
MIME-Version: 1.0
In-Reply-To: <E1aybuF-00044d-BO@sd-51317.xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : testsuite/smokey: Add test
 case for setschedparam & Co, 
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>

On 05/06/2016 11:18 AM, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: dcd6af76837c1afa2941729919337b932b42bd13
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=dcd6af76837c1afa2941729919337b932b42bd13
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Mon Feb 29 16:54:26 2016 +0100
> 
> testsuite/smokey: Add test case for setschedparam & Co,
> 
> This performs basic checks on the correct execution of scheduling
> parameter changes from primary mode.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 

Please do not exit on failure, but unwind and propagate the error up to
the run() handler instead, which should in turn return the status code
to the test driver. Exiting defeats the purpose of passing --keep-going,
which is annoying.

In that respect, the tests from testsuite/smokey that still exit bluntly
on error need fixing.

-- 
Philippe.

