Subject: Re: Best way to detect if a filedescriptor is a cobalt filedescriptor
 (/socket)
References: <VI1PR05MB59172CE94DA6AFD8ADE653CEF6F10@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c71b73d3-fbe8-ada9-a2d0-f960778ca8b5@siemens.com>
Date: Wed, 10 Jul 2019 08:12:48 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59172CE94DA6AFD8ADE653CEF6F10@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 09.07.19 16:49, Lange Norbert via Xenomai wrote:
> Hi,
> 
> I am opening a packetsocket, which is supposed to be realtime. Unfortunatly if the rtpacket (rtnet?) module is not loaded,
> then this will just silently fall back to a linux packet socket. Then later demote thread during accesses.
> 
> How would I be able to detect this early during startup? I could __STD(close) the descriptor and check the returncode for EBADF I suppose...
> 

Yeah, looks this is some feature we lost while embedding the RTDM file
descriptor range into the regular Linux space.

We could either add a compile-time or runtime feature to libcobalt that permits
to disable this silent fallback again or introduce alternative open and socket
implementations that do not expose this behavior. Spontaneously, I would be in
favor or a runtime switch for the existing implementations.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

