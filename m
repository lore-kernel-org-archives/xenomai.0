Subject: Re: rtcap destroys packet contents
References: <VI1PR05MB59178694A8343C2EE1A5081BF6510@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e0003ee1-f8df-e1c3-acd8-601a3a04ffad@siemens.com>
Date: Tue, 17 Dec 2019 08:09:39 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59178694A8343C2EE1A5081BF6510@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 16.12.19 13:36, Lange Norbert via Xenomai wrote:
> Hi,
> 
> I have such a setup, where I push/pull ethernet traffic from an Application every millisecond:
> 
> [App] ---IDDP--> [RTSwitch] --ETH_P_ALL socket--> [rt_igp]
> [App] <---IDDP-- [RTSwitch] <--ETH_P_ALL socket-- [rt_igp]
> [Tun] <---tundev---/
> 
> 
> Now I am sometimes missing packets that the other side should definitely have sent. I wanted to use rtcap
> to inspect this issue, but unfortunately then I get messed up data so that I can't even finish some handshake procedures.
> 
> Is there some incompatibility between RTCAP and ETH_P_ALL (which makes its own copies of rtskb's)?
> Btw, I can't unload rtap/rtnet once loaded.

There is at least no known incompatibility but it may simply have never 
been tested in that combination.

Do you see corruption on packets sent from the rtcap machine or received 
by it?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

