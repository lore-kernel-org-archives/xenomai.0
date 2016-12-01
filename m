Message-ID: <58403FE3.50701@numalliance.com>
Date: Thu, 01 Dec 2016 16:21:07 +0100
From: Benjamin ROUZAUD <brouzaud@numalliance.com>
MIME-Version: 1.0
References: <583D46A3.7010206@numalliance.com>
In-Reply-To: <583D46A3.7010206@numalliance.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Fwd: rt,Heap segfault with unittest
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

We made a new 32 bits system with xeno v3.0.3 .
first question, do we need to switch to git/next branch or keep it ?

During the execution of program using the library xenomai, we met a
problem about allocation memory between two process. Indeed, with a same
session, one program create the differents areas of memories but the
next try and fail. We create a unittest case that reproduces the bug between the
two process. But , since the problem has happened "randomly", depending on running context, we hope you will be able to
reproduce it.

Xenomai is configure with this flags :  --enable-smp, --enable-pshared
--enable-dlopen-libs --enable-tls

You will found the differents files at google drive (cf https://drive.google.com/drive/folders/0B7MmKH2j6iMYWjJfTzVOcFVTRDQ?usp=sharing).
  
You will find  modification of /alchemy/heap.c file trying to
search for the error at processing time. (cf enclosed heap.txt file)

You will find too the two tests programs with a makefile in enclosed heaptest.tar.gz file. The process B
create differents allocation areas and pauses.

projetB --session=t

the process C tries to create or link differents allocation areas but it crashes with segfault after many
creation.

projetC --session=t

Cordially,
B. Rouzaud
R&D Numalliance





