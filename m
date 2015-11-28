Date: Sat, 28 Nov 2015 12:31:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151128113145.GD10399@hermes.click-hack.org>
References: <trinity-1831e513-92b7-4257-8f4e-a09952d12ad0-1448472034310@3capp-webde-bap53>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-1831e513-92b7-4257-8f4e-a09952d12ad0-1448472034310@3capp-webde-bap53>
Subject: Re: [Xenomai] how to force task switch to primary mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JK.Behnke@web.de
Cc: xenomai@xenomai.org

On Wed, Nov 25, 2015 at 06:20:34PM +0100, JK.Behnke@web.de wrote:
>    Hello,
> 
>    an rtdm driver that I use requires the rt_dev_open call to be executed
>    in primary mode.
>    With xenomai 2.4.2 it was possible to switch to primary mode using
>    rt_task_set_mode(0, T_PRIMARY, NULL);
> 
>    Now I use xenomai 2.6.3, but I can't find the T_PRIMARY flag.
>    Is there an other alternative to force the task to switch to primary
>    mode?

I have not reacted earlier. But if you are porting old code to a new
version of Xenomai, there is absolutely no reason to use Xenomai
2.6.3. You could want to stay in the 2.x branch, because for
instance you are using Xenomai skins other than RTDM in kernel
space, but then the version of choice is Xenomai 2.6.4, not 2.6.3.
2.6.4 is API and even ABI compatible with 2.6.3, only with some
known bugs fixed, and support for more recent versions of Linux (and
yes, before you ask, Xenomai 2.6.4 can be used with any version of
Linux for which an I-pipe patch was released before its release,
even 2.4 kernels are supposed to work). 

You should also note that there may be another version of Xenomai
2.6, in order to release the current contents of its git tree, but
once this is done, there will be no plan for a next release. Xenomai
2.6 will be quasi-EOL. The current development branch is Xenomai 3,
so, starting now to use Xenomai 2.6 may not be the best idea.

-- 
					    Gilles.
https://click-hack.org

