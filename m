From: =?utf-8?Q?Christoph_M=C3=BCllner?=
 <christoph.muellner@theobroma-systems.com>
Message-Id: <239A2528-8C25-4293-8832-BA7FB56AF790@theobroma-systems.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Thu, 19 Oct 2017 10:43:31 +0200
In-Reply-To: <d33ebdd9-d449-ca66-e355-f5796378804e@oss-tech.org>
References: <6f474cec-909e-f230-73ff-b3b1fcf9c555@siemens.com>
 <20171012124935.24781-1-christoph.muellner@theobroma-systems.com>
 <a4c6520f-c201-2006-f530-b921d722c3c1@oss-tech.org>
 <6FABE6F5-B367-4A64-A276-2DC2DF18EBA9@theobroma-systems.com>
 <d33ebdd9-d449-ca66-e355-f5796378804e@oss-tech.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: Re: [Xenomai] [PATCH] ipipe: gicv3: [v3] Enable interrupt
	pipelining.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Cc: jan.kiszka@siemens.com, xenomai@xenomai.org

SXMgdGhlcmUgYW55dGhpbmcgZWxzZSBJIGNhbiBkbyB0byBnZXQgdGhpcyBtZXJnZWQ/CgpUaGFu
a3MsCkNocmlzdG9waAoKCj4gT24gMTIgT2N0IDIwMTcsIGF0IDIwOjU5LCBEbWl0cml5IENoZXJr
YXNvdiA8ZG1pdHJpeUBvc3MtdGVjaC5vcmc+IHdyb3RlOgo+IAo+IE9uIDEwLzEyLzIwMTcgMTE6
MTYgQU0sIENocmlzdG9waCBNw7xsbG5lciB3cm90ZToKPiAKPj4gVGhhdCB3YXMgbXkgZmlyc3Qg
YXR0ZW1wdCwgYnV0IHRoYXQgZW5kcyB1cCBpbiBhIGhhbmcgZHVyaW5nIGJvb3R1cC4KPj4gSSBz
dXNwZWN0IHRoYXQgdGhlIC5pcnFfaG9sZCgpIGNhbGxiYWNrIG11c3Qgbm90IGNhbGwgaXBpcGVf
bG9ja19pcnEoKS4KPj4gQW5kIHNpbmNlIEkgYWRkZWQgdGhhdCBjYWxsIHRvIGdpY19tYXNrX2ly
cSgpLCBJIGNhbm5vdCBjYWxsIC5pcnFfbWFzaygpLgo+PiBOb3RlLCB0aGF0IHRoaXMgY29kZSBl
cXVhbHMgYWxzbyB0aGUgR0lDdjIgaW1wbGVtZW50YXRpb24gaW4gZHJpdmVycy9pcnFjaGlwL2ly
cS1naWMuYwo+PiAod2hlcmUgSSBnb3QgdGhlIGlkZWEgZm9yIHRoZSBwaXBlbGluZV9sb2NrKCkg
bWFjcm9zIGluIFt2Ml0gZnJvbSkuCj4+IFRoYW5rcywKPj4gQ2hyaXN0b3BoCj4gCj4gWWVzLCB0
aGF0J3MgY29ycmVjdCAtIGxvY2svdW5sb2NrIGRlZmluaXRlbHkgc2hvdWxkIG5vdCBiZSBjYWxs
ZWQgZnJvbSBob2xkL3JlbGVhc2UuCj4gCj4gVGhpcyBsb29rcyBvayB0byBtZS4gVGhhbmtzIQoK
LS0tLS0tLS0tLS0tLS0gbmV4dCBwYXJ0IC0tLS0tLS0tLS0tLS0tCkEgbm9uLXRleHQgYXR0YWNo
bWVudCB3YXMgc2NydWJiZWQuLi4KTmFtZTogc2lnbmF0dXJlLmFzYwpUeXBlOiBhcHBsaWNhdGlv
bi9wZ3Atc2lnbmF0dXJlClNpemU6IDg0MiBieXRlcwpEZXNjOiBNZXNzYWdlIHNpZ25lZCB3aXRo
IE9wZW5QR1AKVVJMOiA8aHR0cDovL3hlbm9tYWkub3JnL3BpcGVybWFpbC94ZW5vbWFpL2F0dGFj
aG1lbnRzLzIwMTcxMDE5L2RkODBlNjI2L2F0dGFjaG1lbnQuc2lnPgo=
