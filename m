Date: Fri, 21 Aug 2015 11:26:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150821092604.GA12742@hermes.click-hack.org>
References: <1529421239.7462838.1439985533416.JavaMail.yahoo@mail.yahoo.com>
 <CA+CJOCyg6wC9=kOi_XTB2pvrv3EdafLLGqd2TcHgt=KOYWWCNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CJOCyg6wC9=kOi_XTB2pvrv3EdafLLGqd2TcHgt=KOYWWCNQ@mail.gmail.com>
Subject: Re: [Xenomai] (no subject)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nicolas SCHURANDO <schurann@ext.essilor.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Aug 21, 2015 at 11:18:47AM +0200, Nicolas SCHURANDO wrote:
> Hi Mohamed,
> 
> What version of xenomai are you using ? I am going to assume 2.6.x. I
> haven't worked with 3.x yet, and its architecture being different, I don't
> think the following instructions would apply for it.
> 
> Installation of xenomai as explained at
> http://www.xenomai.org/documentation/xenomai-head/pdf/README.INSTALL.pdf is
> achieved through these steps :
> 
>    1. If you are using a non-vanilla kernel, you should check for a
>    possible pre-patch specific for your kernel.
> 
>    2. Prepare your kernel by using the prepare-kernel.sh script.
> 
>    3. Again, if you are using a non-vanilla kernel, check for a possible
>    post-patch to apply.
> 
>    4. Configure your kernel as you would normally do, through "make
>    menuconfig" for example, and ensure the chosen configuration complies with
>    xenomai requirements; see chapter "Kernel configuration" of
>    http://www.xenomai.org/documentation/xenomai-head/pdf/TROUBLESHOOTING.pdf
> 
>    5. Build your kernel, its modules, and deploy them on your target. At
>    this point, you should see a few lines during early boot process if you
>    type "dmesg | grep -i xenomai".
> 
>    6. Finally, build the user-space binaries of xenomai, and deploy them on
>    your target.
> 
> Maybe someone can correct me if I am wrong, but I believe the
> "/proc/xenomai/version" pseudo-file is provided by the kernel, not by the
> user-space binaries. So, if it is missing on your board, it means something
> went wrong somewhere between steps 1 and 5.

The file is provided by the procfs pseudo-filesystem. If the /proc
directory is empty, chances are the /proc filesystem is not even mounted.

-- 
					    Gilles.
https://click-hack.org

