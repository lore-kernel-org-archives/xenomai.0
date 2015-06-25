From: Paul <paul_c@tuxcnc.org>
Date: Thu, 25 Jun 2015 10:39:58 +0100
References: <CA+R+utphWuYg5Xu5u-j9my43wTEkqZfw34mwGUa2_2f_k6TD5w@mail.gmail.com>
In-Reply-To: <CA+R+utphWuYg5Xu5u-j9my43wTEkqZfw34mwGUa2_2f_k6TD5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201506251039.59144.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] Kernel compilation issue for RaspberryPi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Thursday 25 June 2015, Antoine Demirdjian wrote:
> [linux] $* make ARCH=arm defconfig*
[...]
> *** Default configuration is based on 'versatile_defconfig'

Try again with one of the default bcmrpi_* configs - You will probably 
want to tweak the CPU_FREQ options.

