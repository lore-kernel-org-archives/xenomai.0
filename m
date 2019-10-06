Subject: Re: ARM reference platform(s)
References: <CAFc1U0sYmwMNY1yE+B6=x3_C9QKb9PYivkqDztMSckPXqeUTQw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8ba27533-1944-164f-30cc-17c1bc832e51@xenomai.org>
Date: Sun, 6 Oct 2019 18:38:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAFc1U0sYmwMNY1yE+B6=x3_C9QKb9PYivkqDztMSckPXqeUTQw@mail.gmail.com>
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
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai@xenomai.org

On 9/30/19 5:01 PM, Pierre FICHEUX via Xenomai wrote:
> Hi all,
> 
> Do you have a list  of ARM reference platforms used for Ipipe test and
> validation (by the core developers) ?
> 

armv7: several i.MX6 processors (fsl/nxp sabre, phytec, via), i.MX7
(nxp), RPI2, Xilinx Cyclone-V and STmicro B2260 mainly. BBB less frequently.

armv8: hikey (Kirin 620 so far, 970 may come at some point), RPI3,
Xilinx ZCU102.

-- 
Philippe.

