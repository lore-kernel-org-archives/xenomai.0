Message-ID: <52F105C4.60307@xenomai.org>
Date: Tue, 04 Feb 2014 16:22:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1WAhle-0006kB-0q@sd-51317.dedibox.fr>
In-Reply-To: <E1WAhle-0006kB-0q@sd-51317.dedibox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : alchemy: Replace static
 variable no_alchemy_task with macro
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 02/04/2014 04:18 PM, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: bffcc58ed0114985a4d8d8a4cff2adff1b13292d
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=bffcc58ed0114985a4d8d8a4cff2adff1b13292d
>
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Tue Feb  4 16:12:07 2014 +0100
>
> alchemy: Replace static variable no_alchemy_task with macro
>
> The current definition of a static const variable representing an
> invalid alchemy task is both C++-incompatible and also ugly as we do not
> use them in every module that includes task.h. So replace it with a
> macro that builds the required struct on-the-fly.

Well, this structure is valid C99, is not there any way to get the C++ 
compiler to accept it ? Like -std=c++11 ?


-- 
					    Gilles.

