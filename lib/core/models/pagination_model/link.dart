class Link {
	String? url;
	String? label;
	bool? active;

	Link({this.url, this.label, this.active});

	@override
	String toString() => 'Link(url: $url, label: $label, active: $active)';

	factory Link.fromJson(Map<String, dynamic> json) => Link(
				url: json['url'] as String?,
				label: json['label'] as String?,
				active: json['active'] as bool?,
			);

	Map<String, dynamic> toJson() => {
				'url': url,
				'label': label,
				'active': active,
			};
}
