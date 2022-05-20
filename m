From: Gunter Grau <guntgrau@bbl.ma.philips.com>
Subject: Re: Bug in xenomai 3.2.x on ARM
Date: Fri, 20 May 2022 16:29:12 +0200
Message-Id: <20220520142913.2081560-1-guntgrau@bbl.ma.philips.com>
In-Reply-To: <d00-62584d80-1a5-12ac4c80@96928095>
References: <d00-62584d80-1a5-12ac4c80@96928095>
Reply-To: Gunter Grau <gunter.grau@philips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

We also saw this issue when porting out application to Xenomai 3.2 with imx6.
Looks like the return value in upstream is still defined to be not always 0 on success. So we wrote a patch.
It looks like this happend when dovetail was introduced.

The patch only applies to Xenomai 3.2 since ipipe is not part of the
master anymore.

Regards, Gunter




