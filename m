From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 1 Oct 2014 21:47:21 -0400
Message-ID: <20141002014721.GK4435@csclub.uwaterloo.ca>
References: <CANgF67Q+ZneJM-osJT07NS45AWaZEPetHjUL5EBc5SvW0Dc7rQ@mail.gmail.com>
 <20141001213611.GI4435@csclub.uwaterloo.ca>
 <CANgF67SoFqOZtcC87Wy04RT5ARqK2+H8w+b79Yvf3d_QcnqAjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgF67SoFqOZtcC87Wy04RT5ARqK2+H8w+b79Yvf3d_QcnqAjQ@mail.gmail.com>
Subject: Re: [Xenomai] nucleus/sched.h: No such file or directory
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: agnes jurek <agnessjurek@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Oct 02, 2014 at 12:46:22AM +0300, agnes jurek wrote:
> @Lennart, you said "you don't have to put xenomai/ in your #include
> statements though.". But when I added  "#include <rtdm/rtdm.h>" and
> "-lrtdm" on linking, I got error. If I add "#include
> <xenomai/rtdm/rtdm.h>", it is ok.

Did you add -I/usr/include/xenomai to your compile line?  Doing that
would make that problem go away.

-- 
Len Sorensen

