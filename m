Date: Wed, 9 Mar 2005 08:31:59 +0100
Subject: Re: [Adeos-main] rtai-config in ADEOS?
Message-ID: <20050309073159.GA7610@domain.hid>
References: <20050304142640.965103e9de0b4a7195ff6a99a6d9901a.in@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304142640.965103e9de0b4a7195ff6a99a6d9901a.in@domain.hid>
From: kleine-budde@domain.hid (Marc Kleine-Budde)
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Jason Huang <jason.huang@domain.hid>
Cc: adeos-main@gna.org, rtnet-users@domain.hid

On Fri, Mar 04, 2005 at 02:47:43PM -0800, Jason Huang wrote:
> When I configured the RTnet, it looked for $RTAI_DIR/bin/rtai-config.
> Where do I found it under ADEOS?

RTnet cannot work directly under ADEOS, you need RTAI [1] on Adeos in
order to run RTnet.

If you have already downloaded and compiled RTAI, you need to install
it. Run RTnet's configure as shown in the README [2] with path to the
RTAI installation. RTAI's default installation path is /usr/realtime, so
the configure would look like this:

./configure --with-rtai=/usr/realtime

hth - Marc

[1] http://www.rtai.org/
[2] http://www.rts.uni-hannover.de/rtnet/lxr/source/README#L30

-- 
#!/bin/sh
set - `type $0` 'tr "[a-zA-Z]" "[n-za-mN-ZA-M]"';while [ "$2" != "" ];do \
shift;done; echo 'frq -a -rc '`echo "$0"| $1 `'>$UBZR/.`rpub signature|'`\
echo $1|$1`'`;rpub "Jr ner fvtangher bs obet. Erfvfgnapr vf shgvyr!"'|$1|sh

